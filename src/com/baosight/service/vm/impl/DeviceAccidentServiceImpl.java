package com.baosight.service.vm.impl;

import com.baosight.base.aspect.AspectTime;
import com.baosight.base.enumeration.DeviceAccidentStatus;
import com.baosight.base.page.PageVo;
import com.baosight.base.page.PageVoUtils;
import com.baosight.base.utils.FileNameUtils;
import com.baosight.base.utils.FileUtils;
import com.baosight.dto.common.DeleteDTO;
import com.baosight.dto.cx.resp.FileDTO;
import com.baosight.dto.equipment.query.YWHKDeviceQueryDTO;
import com.baosight.dto.vm.query.DeviceAccidentQueryDTO;
import com.baosight.dto.vm.req.DeviceAccidentReqDTO;
import com.baosight.dto.vm.resp.DeviceAccidentRespDTO;
import com.baosight.entity.equipment.YWHKDeviceEntity;
import com.baosight.entity.vm.DeviceAccidentEntity;
import com.baosight.iplat4j.core.web.threadlocal.UserSession;
import com.baosight.mapper.base.BaseDeleteMapper;
import com.baosight.mapper.equipment.YWHKDeviceDao;
import com.baosight.mapper.vm.DeviceAccidentDao;
import com.baosight.service.vm.DeviceAccidentService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import net.sf.json.JSONObject;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @ClassName DeviceAccidentServiceImpl
 * @Description DOTO
 * @Author xu
 * @Date 2020/9/8 15:43
 */
@Service
public class DeviceAccidentServiceImpl implements DeviceAccidentService {

    @Autowired
    private DeviceAccidentDao deviceAccidentDao;
    @Autowired
    private BaseDeleteMapper baseDeleteMapper;
    @Autowired
    private YWHKDeviceDao ywhkDeviceDao;

    //    @Autowired
//    private RuntimeService runtimeService;
    @Autowired
    private TaskService taskService;
    //    @Autowired
//    private RepositoryService repositoryService;
//    @Autowired
//    private HistoryService historyService;
    @Autowired
    private ProcessEngine processEngine;

//    @Autowired
//    private IdentityService identityService;

    /**
     * 突发事件列表
     *
     * @param queryDTO
     * @return
     */
    @Override
    public PageVo findPageList(DeviceAccidentQueryDTO queryDTO) {
        PageHelper.startPage(queryDTO.getPageNo(), queryDTO.getPageSize());
        if (queryDTO.getIndexStatus() == DeviceAccidentStatus.TAB_INDEX) {
            queryDTO.setFinderJob(UserSession.getLoginName());
        } else {
            queryDTO.setAccepterJob(UserSession.getLoginName());
        }
        // 组织树查询
        if (!StringUtils.isEmpty(queryDTO.getOrganizationId())) {
            queryDTO.setDeviceIdList(findDevIdList(queryDTO.getOrganizationId()));
        }
        List<DeviceAccidentEntity> devicePollEntities = deviceAccidentDao.selectDeviceAccidentList(queryDTO);
        return PageVoUtils.pageFromMybatis(new PageInfo<>(devicePollEntities), DeviceAccidentRespDTO.class);
    }

    /**
     * 获取自己待办任务
     *
     * @return
     */
    @Override
    public PageVo findAllActivity(DeviceAccidentQueryDTO queryDTO) {
        PageHelper.startPage(queryDTO.getPageNo(), queryDTO.getPageSize());
        List<Task> tasks = taskService // 与任务相关的Service
                .createTaskQuery() // 创建一个任务查询对象
                .taskAssignee(UserSession.getLoginName())
                .list();
        List<String> taskIds;
        if (CollectionUtils.isEmpty(tasks)) {
            PageInfo page = new PageInfo();
            page.setPageSize(queryDTO.getPageSize());
            page.setPageNum(queryDTO.getPageNo());
            return PageVoUtils.pageFromMybatis(page, DeviceAccidentRespDTO.class);
        }
        if (CollectionUtils.isNotEmpty(tasks)) {
            taskIds = tasks.stream().map(Task::getProcessInstanceId).collect(Collectors.toList());
            queryDTO.setTaskList(taskIds);
            queryDTO.setAccepterJob(UserSession.getLoginName());
            // 组织树查询
            if (!StringUtils.isEmpty(queryDTO.getOrganizationId())) {
                queryDTO.setDeviceIdList(findDevIdList(queryDTO.getOrganizationId()));
            }
        }
        List<DeviceAccidentEntity> devicePollEntities = deviceAccidentDao.selectActiviti(queryDTO);
        return PageVoUtils.pageFromMybatis(new PageInfo<>(devicePollEntities), DeviceAccidentRespDTO.class);
    }

    /**
     * 组织下所有设备
     *
     * @param organizationId
     * @return
     */
    public List<Integer> findDevIdList(int organizationId) {
        YWHKDeviceQueryDTO cameraDataQueryDTO = new YWHKDeviceQueryDTO();
        cameraDataQueryDTO.setDeviceOrganizationId(organizationId);
        return ywhkDeviceDao.selectDevOrganization(cameraDataQueryDTO).stream().map(YWHKDeviceEntity::getId)
                .distinct().collect(Collectors.toList());
    }

    /**
     * 突发事件列表
     *
     * @param queryDTO
     * @return
     */
    @Override
    public PageVo findAllPageList(DeviceAccidentQueryDTO queryDTO) {
        PageHelper.startPage(queryDTO.getPageNo(), queryDTO.getPageSize());
        List<DeviceAccidentEntity> devicePollEntities = deviceAccidentDao.selectDeviceAccidentList(queryDTO);
        return PageVoUtils.pageFromMybatis(new PageInfo<>(devicePollEntities), DeviceAccidentRespDTO.class);
    }

    /**
     * 审批者自己添加报警信息
     *
     * @param file
     * @param jsonReqDTO
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public boolean fileUpload(MultipartFile file, String jsonReqDTO) {
        JSONObject jsonObject = JSONObject.fromObject(jsonReqDTO);
        DeviceAccidentReqDTO reqDTO = (DeviceAccidentReqDTO) JSONObject.toBean(jsonObject, DeviceAccidentReqDTO.class);
        FileDTO fileDTO = realPath(file);
        // 启用审批工作流
        RuntimeService runtimeService = processEngine.getRuntimeService();
        ProcessInstance pi = runtimeService.startProcessInstanceByKey("leave");
        Task task = taskService.createTaskQuery().processInstanceId(pi.getId()).singleResult();
        taskService.setAssignee(task.getId(), reqDTO.getAccepterJob());
        if (FileUtils.upload(file, fileDTO.getRealPath())) {
            DeviceAccidentEntity accidentEntity = new DeviceAccidentEntity();
            BeanUtils.copyProperties(reqDTO, accidentEntity);
            accidentEntity.setPicUrl(fileDTO.getDbName());
            accidentEntity.setStatus(DeviceAccidentStatus.UNTREATED);
            accidentEntity.setProcessId(pi.getId());
            accidentEntity.setFinderName(UserSession.getLoginName());
            accidentEntity.setFinderJob(UserSession.getLoginCName());
            deviceAccidentDao.insert(accidentEntity);
            return true;
        }
        return false;
    }

    /**
     * 审批突发事件
     *
     * @param file
     * @param jsonReqDTO
     * @return
     */
    @Override
    public boolean examine(MultipartFile file, String jsonReqDTO) {
        JSONObject jsonObject = JSONObject.fromObject(jsonReqDTO);
        DeviceAccidentReqDTO reqDTO = (DeviceAccidentReqDTO) JSONObject.toBean(jsonObject, DeviceAccidentReqDTO.class);
        FileDTO fileDTO = realPath(file);
        DeviceAccidentEntity deviceAccidentEntity = new DeviceAccidentEntity();
        BeanUtils.copyProperties(reqDTO, deviceAccidentEntity);
        deviceAccidentDao.updateByPrimaryKeySelective(deviceAccidentEntity);
        Task task = taskService.createTaskQuery().processInstanceId(reqDTO.getProcessId()).singleResult();
        Map<String, Object> args = new HashMap<>();
        args.put("formId", deviceAccidentEntity.getId());
        taskService.complete(task.getId(), args);
        System.out.println(task.getName());
        ProcessInstance pi = processEngine.getRuntimeService() // 获取运行时Service
                .createProcessInstanceQuery() // 创建流程实例查询
                .processInstanceId(reqDTO.getProcessId()) // 用流程实例ID查询
                .singleResult();
        if (pi == null) {
            if (FileUtils.upload(file, fileDTO.getRealPath())) {
                deviceAccidentEntity.setStatus(DeviceAccidentStatus.PROCESSED);
                deviceAccidentEntity.setDisposerPicUrl(fileDTO.getDbName());
                deviceAccidentDao.updateByPrimaryKeySelective(deviceAccidentEntity);
                System.out.println("流程已经执行结束！");
            }
        }
        return false;
    }

    public FileDTO realPath(MultipartFile file) {
        FileDTO fileDTO = new FileDTO();
        String localPath = "C:/img";
//        String localPath = "/Users/admin/Downloads/img";
        String newName = FileNameUtils.getFileName(file.getOriginalFilename());
        String realPath = localPath + "/" + newName;
        String local = UserSession.getContextPath().replaceAll("/mgvideo", "");
        String dbName = "http://" + local + "/img/" + newName;
        fileDTO.setRealPath(realPath);
        fileDTO.setDbName(dbName);
        return fileDTO;
    }


    /**
     * 批量删除
     *
     * @param deleteDTO
     */
    @Override
    public void deleteBatch(DeleteDTO deleteDTO) {
        deleteDTO.setTableName(new DeviceAccidentEntity().getDynamicTableName());
        baseDeleteMapper.deleteBatch(deleteDTO);
    }

    /**
     * 新增突发事件
     *
     * @param record
     * @return
     */
    @AspectTime(operation = "create")
    @Override
    public boolean save(DeviceAccidentReqDTO record) {
        // 启用审批工作流
        RuntimeService runtimeService = processEngine.getRuntimeService();
        ProcessInstance pi = runtimeService.startProcessInstanceByKey("leave");
        Task task = taskService.createTaskQuery().processInstanceId(pi.getId()).singleResult();
        taskService.setAssignee(task.getId(), record.getAccepterJob());
        // 新增
        DeviceAccidentEntity deviceAccidentEntity = new DeviceAccidentEntity();
        BeanUtils.copyProperties(record, deviceAccidentEntity);
        deviceAccidentEntity.setStatus(DeviceAccidentStatus.UNTREATED);
        deviceAccidentEntity.setProcessId(pi.getId());
        deviceAccidentEntity.setFinderName(UserSession.getLoginName());
        deviceAccidentEntity.setFinderJob(UserSession.getLoginCName());
        deviceAccidentDao.insert(deviceAccidentEntity);
        return true;
    }


    /**
     * 修改`
     *
     * @param record
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public boolean update(DeviceAccidentReqDTO record) {
//        DeviceAccidentEntity deviceAccidentEntity = new DeviceAccidentEntity();
//        BeanUtils.copyProperties(record, deviceAccidentEntity);
//        deviceAccidentDao.updateByPrimaryKeySelective(deviceAccidentEntity);
//        Task task = taskService.createTaskQuery().processInstanceId(record.getProcessId()).singleResult();
//        Map<String, Object> args = new HashMap<>();
//        args.put("formId", deviceAccidentEntity.getId());
//        taskService.complete(task.getId(), args);
//        System.out.println(task.getName());
//        ProcessInstance pi = processEngine.getRuntimeService() // 获取运行时Service
//                .createProcessInstanceQuery() // 创建流程实例查询
//                .processInstanceId(record.getProcessId()) // 用流程实例ID查询
//                .singleResult();
//        if (pi == null) {
//            deviceAccidentEntity.setStatus(DeviceAccidentStatus.PROCESSED);
//            deviceAccidentDao.updateByPrimaryKeySelective(deviceAccidentEntity);
//            System.out.println("流程已经执行结束！");
//        }
        return true;
    }

    @Override
    public void delete(String ids) {

    }


}
