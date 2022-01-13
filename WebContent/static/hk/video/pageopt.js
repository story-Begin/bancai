/**
 * Created by Administrator on 2018/3/23.
 */
    var selectedVal="";
    var setting = {
    data: {
        simpleData: {
            enable: true
        }
    },
    check: {
        enable: false
    },
    view: {
        dblClickExpand: false,
        showLine: true,
        selectedMulti: true,
        fontCss: setFontCss
    },
    callback: {
        beforeAsync: function () {

        },
        beforeClick: function (treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("tree_project");
            if (treeNode.isParent) {
                zTree.expandNode(treeNode);
                return false;
            } else {

                return true;
            }
        },
        onDblClick: zTreeOnDblClick
    }
};
    var index=1;
//双击事件
function zTreeOnDblClick(event, treeId, treeNode) {
    selectedVal=treeNode.info3;
    if(selectedVal!=""){

        startVideo(selectedVal);
        //调用此方法，记录调用视频次数
        JY.Ajax.doRequest(null,jypath +'/backstage/bgwbhy/video/getPreviewURLByIp',null,function(data){

        });
    }
};

function loadVideo(id){
    JY.Ajax.doRequest(null, jypath + '/backstage/bgwbhy/hk_device/getPreviewParameters', {cameraUuid:id}, function (data) {
        if(data.res==0){
            alert(data.resMsg);
        }
        else{
            // objId=id; //主键

            // 调OCX单路预览接口
            var spvxOcx = document.getElementById("spv");
            var xml=getJsonToUnescape(data.obj);

            if (xml)
            {
                var ret = 0;
                var opt = 0;
                ret = spvxOcx.SPV_StartPreview(xml); //需要将xml里面的特殊字符进行转义
                if (ret != 0) {
                    alert("预览失败!" );
                }
            }
            else
            {
                var vDesc = "查询预览参数失败";
                alert(vDesc);
            }
        }
    },false);
}
function  getVideoXml(IpAddress ) {
    /*根据厂区编码查询设备数据*/
    $.ajax({
        type: "POST",
        url: "http://10.25.71.40:8080/bgwbhy//backstage/bgwbhy/hk_device/getPreviewParametersByIp",
        data: "IpAddress=" + IpAddress,
        success: function (msg) {
            // 调OCX单路预览接口
            var spvxOcx = document.getElementById("spv");
            var xml=getJsonToUnescape(data.obj);
            if (xml)
            {
                var ret = 0;
               ret = spvxOcx.MPV_StartPreview(xml); //需要将xml里面的特殊字符进行转义
                if (ret != 0) {
                    alert("预览失败!" );
                }
            }
            else
            {
                var vDesc = "查询预览参数失败";
                alert(vDesc);
            }
        }
    })
}

function  zTreeOnClick(event, treeId, treeNode){
    selectedVal=treeNode.info3;
    if(selectedVal!=""){
    startVideo(selectedVal);
    }
  }
Array.prototype.method1 = function (obj) {
    var arr=[];    //定义一个临时数组
    for (var i = 0; i < obj.length; i++) {    //循环遍历当前数组
        //判断当前数组下标为i的元素是否已经保存到临时数组
        //如果已保存，则跳过，否则将此元素保存到临时数组中
        if (arr.indexOf(obj[i]) == -1) {
            arr.push(obj[i]);
        }
    }
    return arr;
} ;

// json字符串中特殊字符转译后还原
 function getJsonToUnescape(json) {
     if (!json) return "";
     json = json.replace(/(&amp;)/g, "&");
     json = json.replace(/(&#39;)/g, "'");
     json = json.replace(/(&lt;)/g, "<");
     json = json.replace(/(&gt;)/g, ">");
     json = json.replace(/(&apos;)/g, "'");
     json = json.replace(/(&quot;)/g, "\"");

     json = json.replace(/(&ldquo;)/g, "“");
     json = json.replace(/(&rdquo;)/g, "”");
     json = json.replace(/(&amp;)/g, "&");
    // json = json.replace(/(\n)/g, "");
     return json; // 返回参数值
 }
var treenode=null;
var allnum=0;
var onlinenum=0;
var unlinenum=0;
function onloadtree() {
 //获取视频树 findForVideoByTree

    JY.Ajax.doRequest(null,jypath +'/backstage/bgwbhy/video/findVideoTreeByAuthority',null,function(data){
        allnum=0;
        onlinenum=0;
        unlinenum=0;
        treenode=data.obj;
        result=treenode;
       for(var i=0;i<treenode.length;i++){
           if(treenode[i].type==""||treenode[i].type==null)
               treenode[i].iconSkin="icon03";
           else if(treenode[i].type.indexOf("球机")){
           treenode[i].iconSkin="icon01";
       }
       else if(treenode[i].type.indexOf("枪机")||treenode[i].type.indexOf("筒机")||treenode[i].type.indexOf("半球"))
       {
           treenode[i].iconSkin="icon02";
       }

        }

        var t = $("#tree_project");
        t = $.fn.zTree.init(t, setting, treenode);
      //  t.expandAll(t);
        var nodes =  t.getNodes();

        for (var i = 0; i < nodes.length; i++) { //设置节点展开

            t.expandNode(nodes[i], true, false, true);

        }

    });


}
function setFontCss(treeId, treeNode) {
	return treeNode.status == 0 ? {color:"#746f6f"} : {color:"white"};
};
function onlodtree_online() {

    // JY.Ajax.doRequest(null,jypath +'/backstage/bgwbhy/video/findVideoTreeByAuthority',null,function(data){
    var path=jypath+"/backstage/equipment/organization/powerOrganizationEquipmentTree";
      $.ajax({
          type:"POST",
          async:true,
          url: path,
          dataType:"json",
          success: function(data) {
              if (data.res >= 1) {
                  allnum = 0;
                  onlinenum = 0;
                  unlinenum = 0;
                  treenode = treenode_iconSkin(data.obj);
                  var t = $("#tree_project");
                  t = $.fn.zTree.init(t, setting, treenode);

                  var nodes = t.getNodes(); //可以获取所有的父节点
                  for (var i = 0; i < nodes.length; i++) { //设置节点展开
                      t.expandNode(nodes[i], true, false, true);
                  }
                  var nodesSysAll = t.transformToArray(nodes); //获取树所有节点
                  var nodes0 = t.getNodesByFilter(filter0);
                  var nodes1 = t.getNodesByFilter(filter1);
                  var nodes2 = t.getNodesByFilter(filter2);

                  function filter2(node) {
                      return (node.level == 2);
                  }

                  function filter1(node) {
                      return (node.level == 1);
                  }

                  function filter0(node) {
                      return (node.level == 0);
                  }


                  for (var m = 0; m < nodes2.length; m++) {
                      if (nodes2[m].info3 == null) {
                          nodes2[m].dev_count = nodes2[m].children.length;
                          nodes2[m].name = nodes2[m].name + " [" + nodes2[m].dev_count + "]";
                      }
                  }
                  for (var n = 0; n < nodes1.length; n++) {
                      var childcode = nodes1[n].children;
                      var len = childcode.length;
                      for (var k = 0; k < len; k++) {
                          nodes1[n].dev_count = parseInt(nodes1[n].dev_count) + parseInt(childcode[k].dev_count);
                      }
                      nodes1[n].name = nodes1[n].name + " [" + nodes1[n].dev_count + "]";
                      t.updateNode(nodes1[n]);
                  }
                  var childcode1 = nodes0[0].children;
                  for (var l = 0; l < childcode1.length; l++) {
                      nodes0[0].dev_count = parseInt(nodes0[0].dev_count) + parseInt(childcode1[l].dev_count);
                  }
                  nodes0[0].name = nodes0[0].name + " [" + nodes0[0].dev_count + "]";
                  t.updateNode(nodes0[0]);
              }
              else {
                  alert(data.resMsg);
              }
          }
     });

}

function findNodes(treeNode)
{
    var count;
    /*判断是不是父节点,是的话找出子节点个数，加一是为了给新增节点*/
    if(treeNode.isParent) {
        count = treeNode.children.length + 1 ;
    } else {
        /*如果不是父节点,说明没有子节点,设置为1*/
        count = 1;
    }
    return count;
}

function onlodtree_unline() {
    JY.Ajax.doRequest(null,jypath +'/backstage/bgwbhy/video/findVideoTreeByAuthority',null,function(data){
        allnum=0;
        onlinenum=0;
        unlinenum=0;

        treenode=data.obj;
        var obj=[];
        for(var i=0;i<treenode.length;i++) {
            if (treenode[i].status == "5" || treenode[i].status == null) {
                obj.push(treenode[i]);
            }
        }
        for(var i=0;i<obj.length;i++){
            if(obj[i].type=="球机"){
                obj[i].iconSkin="icon01";
            }
            else if(obj[i].type=="枪机"||obj[i].type=="筒机"||obj[i].type=="半球")
            {
                obj[i].iconSkin="icon02";
            }
            else  if(obj[i].type==""||obj[i].type==null)
                obj[i].iconSkin="icon03";
        }

        var t = $("#tree_project");
        t = $.fn.zTree.init(t, setting, obj);
        t.expandAll(true);
       // var nodes =  t.getNodes();

        //for (var i = 0; i < nodes.length; i++) { //设置节点展开

           // t.expandNode(nodes[i], true, false, true);


       // }


    });

}



//查询事件
function  btnSearchVideo() {
    var checkinfo  =$('#tbxsearch').val();
    JY.Ajax.doRequest(null,jypath +'/backstage/bgwbhy/video/findVideoByZnodes', {device_bh: checkinfo},function(data){
        if(data.res==0){
            alert(data.resMsg);
        }
        else{
            var t = $("#tree_project");
            var treenode=treenode_iconSkin(data.obj);
            t = $.fn.zTree.init(t, setting, treenode);
        }
    });

}


//树加载内容添加iconSkin
function  treenode_iconSkin(treenode) {

    for(var i=0;i<treenode.length;i++){
        if(treenode[i].type==""||treenode[i].type==null)
            treenode[i].iconSkin="icon03";
        else if(treenode[i].type.indexOf("球机")>=0){
            treenode[i].iconSkin="icon01";
        }
        else if(treenode[i].type.indexOf("枪机")>=0||treenode[i].type.indexOf("筒机")>=0||treenode[i].type.indexOf("半球")>=0)
        {
            treenode[i].iconSkin="icon02";
        }
        else
        { treenode[i].iconSkin="icon02";}

    }
    return treenode;
}


