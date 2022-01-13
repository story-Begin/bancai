package com.baosight.service.vm;

import com.baosight.base.baseService.BaseService;
import com.baosight.base.page.PageVo;
import com.baosight.dto.common.DeleteDTO;
import com.baosight.dto.vm.query.DeviceAccidentQueryDTO;
import com.baosight.dto.vm.req.DeviceAccidentReqDTO;
import org.springframework.web.multipart.MultipartFile;

/**
 * @ClassName DeviceAccidentService
 * @Description DOTO
 * @Author xu
 * @Date 2020/9/8 15:41
 */
public interface DeviceAccidentService extends BaseService<DeviceAccidentReqDTO> {

    /**
     * 突发事件列表
     *
     * @param queryDTO
     * @return
     */
    PageVo findPageList(DeviceAccidentQueryDTO queryDTO);

    /**
     * 展示所有数据列表
     *
     * @param queryDTO
     * @return
     */
    PageVo findAllPageList(DeviceAccidentQueryDTO queryDTO);

    /**
     * 获取当前审批事务
     *
     * @return
     */
    PageVo findAllActivity(DeviceAccidentQueryDTO queryDTO);

    /**
     * 自己添加报警信息
     *
     * @param file
     * @param jsonReqDTO
     */
    boolean fileUpload(MultipartFile file, String jsonReqDTO);

    /**
     * 审批
     *
     * @param file
     * @param jsonReqDTO
     * @return
     */
    boolean examine(MultipartFile file, String jsonReqDTO);

    /**
     * 批量删除
     *
     * @param deleteDTO
     */
    void deleteBatch(DeleteDTO deleteDTO);


}
