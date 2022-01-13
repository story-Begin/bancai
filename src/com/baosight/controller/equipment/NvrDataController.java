package com.baosight.controller.equipment;

import com.baosight.controller.http.HttpResult;
import com.baosight.dto.equipment.query.NvrDataQueryDTO;
import com.baosight.dto.equipment.req.NvrDataReqDTO;
import com.baosight.service.equipment.NvrDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName NvrDataController
 * @Description
 * @Author xu
 * @Date 2020/7/15 9:47
 */
@RestController
@RequestMapping("/backstage/equipment/nvr")
public class NvrDataController {

    @Autowired
    private NvrDataService nvrDataService;

    /**
     * 录像机信息分页列表
     *
     * @param queryDTO
     * @return
     */
    @PostMapping("/nvrDataList")
    public HttpResult findPageList(@RequestBody NvrDataQueryDTO queryDTO) {
        return HttpResult.ok(nvrDataService.findPageList(queryDTO));
    }

    /**
     * 添加录像机
     *
     * @param reqDTO
     * @return
     */
    @PostMapping("/save")
    public HttpResult save(@RequestBody NvrDataReqDTO reqDTO) {
        nvrDataService.save(reqDTO);
        return HttpResult.ok("添加成功！");
    }

    /**
     * 修改录像机
     *
     * @param reqDTO
     * @return
     */
    @PostMapping("/update")
    public HttpResult update(@RequestBody NvrDataReqDTO reqDTO) {
        nvrDataService.update(reqDTO);
        return HttpResult.ok("修改成功！");
    }

    /**
     * 删除录像机
     *
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    public HttpResult delete(@RequestBody String ids) {
        nvrDataService.delete(ids);
        return HttpResult.ok("删除成功！");
    }

}
