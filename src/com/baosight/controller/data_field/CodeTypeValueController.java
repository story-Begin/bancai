package com.baosight.controller.data_field;

import com.baosight.controller.http.HttpResult;
import com.baosight.service.data_field.CodeTypeValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName CodeTypeValueController
 * @Description TODO
 * @Autgor huang
 * @Date 2020-08-26 17:31
 */
@RestController
@RequestMapping("/backstage/data/codeTypeValue")
public class CodeTypeValueController {

    @Autowired
    private CodeTypeValueService codeTypeValueService;

    /**
     * 代码类型值
     *
     * @return
     */
    @GetMapping(value = "/selectCodeTypeValue")
    public HttpResult findByCodeType(String itemCode) {
        return HttpResult.ok(codeTypeValueService.findCodeTypeValueList(itemCode));
    }

}
