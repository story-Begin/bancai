(function($){
	var zTreeArray = new Array();
	$.fn.deviceTree={
		    init:function deviceTree(zSetting){
		        var zTree = (function(){
					var setting = {
						async:{
							enable:true,
							url : function(treeId,treeNode) {//获取节点数据的URL地址
						//		var searchKey = $("#"+setting.other.treeDivId+" input[name='searchKey']");
						//		searchKey = searchKey.val()?searchKey.val():"";
						//		var param = "searchKey="+searchKey;
								var param = "";
								if(treeNode){
									var curCount = (treeNode.childNo) ? treeNode.childNo : 0;
										param +="curCount="+curCount;
									}
									//return setting.other.appath+"/admin/ztree.do?ztree=ztree&" + param;
									return setting.other.url+"?" + param;
								},
								autoParam:["id"] //获取节点数据时，必须的数据名称，例如：id、name
						},
						check:{
							chkboxType:{"Y":"s", "N":"s"},
							enable:true
						},
						view:{
                            
						},
						edit:{
							
						},
						data: {
							simpleData: {
								enable: true,
								idKey: "id",
								pIdKey: "pId",
								rootPId: null
							}
						},

						other:{//自定义属性，用来设置个性化参数
							moveType:[],//可拖动节点类型
							openRoot:false,//是否展开根节点
							treeWindowPosition:{"left":400,"top":300,"width":300,"height":400},
							searchKeyType:"name",
							jsonNodes:[]
						},
						callback: {
							onDrop: function(event, treeId, treeNode, targetNode, moveType) {//节点拖动后调用
								try{
									
									var selectedNodes = zTreeArray[treeId].getSelectedNodes();
									if($.inArray(selectedNodes[0].type,setting.other.moveType) != -1) onDrop(selectedNodes[0]);//调用页面实现，对拖动节点的处理
								}catch(e){
								
								}
							},
							beforeDrag : function(treeId, treeNode){//节点拖动前调用
									return $.inArray(treeNode[0].type,setting.other.moveType) != -1;
							},
							beforeExpand : function(treeId, treeNode) {//展开节点前调用
								if(!treeNode.isParent)return false;
								if(treeNode.children)return true;
								if (!treeNode.isAjaxing) {
									zTreeArray[treeId].reAsyncChildNodes(treeNode, "refresh");
									return true;
								} else {
									alert(getLocaleMessage("ztree.onAsyncing"));
									return false;
								}
								return true;
							},
							onAsyncError : function(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown) {//异步加载数据出错
								alert(getLocaleMessage("ztree.onAsyncError"));
								treeNode.icon = "";
								zTreeArray[treeId].updateNode(treeNode);
							},
							onAsyncSuccess : function(event, treeId, treeNode, msg){
								if(zTreeArray[treeId].setting.check.enable){
									changeTreeNodesStatus(zTreeArray[treeId],treeNode);//改变节点的选择状态
								}
								/*
								if(zTreeArray[treeId].setting.other.openRoot){
									//var rootNode = zTreeArray[treeId].getNodeByParam("type","01");
									var rootNodes = zTreeArray[treeId].getNodes();
									var rootNode = null==rootNodes ? null : rootNodes[0];
									
									if(rootNode && !rootNode.open){
										zTreeArray[treeId].expandNode(rootNode,true,false);
									}
								}
								*/
							},
							onNodeCreated : function (event, treeId, treeNode) {//创建节点时用来改变子节点的选择状态
								callBackOnNodeCreated(event, treeId, treeNode);
							},
							beforeDrop : function(treeId, treeNodes, targetNode, moveType){//节点拖动前调用
								//限制只能在相同组织下设备之间进行排序移动
								if(targetNode.type==1||(targetNode.getParentNode()&&(targetNode.getParentNode().id!=treeNodes[0].getParentNode().id)))return false;
								if(!confirm(getLocaleMessage("ztree.drop.confirm")))return false;
								orderDevice(treeId,treeNodes[0],targetNode,moveType);
								return true;
							},
							onCheck : function(event, treeId, treeNode){
								var jsonNodes = checkNode(zTreeArray[treeId].setting.other.jsonNodes,treeNode);
								zTreeArray[treeId].setting.other.jsonNodes = jsonNodes;
							}
						}
					};		
					$.extend(true, setting, zSetting);
					$("#"+setting.other.treeDivId+" .ztree").attr("id",setting.other.treeDivId+"_zTree");//需要设置树的id,在ztree的js中用到
					return $.fn.zTree.init($("#"+setting.other.treeDivId+" ul"),setting,null);
			})();
			zTreeArray[zTree.setting.other.treeDivId+"_zTree"]=zTree;
			
			refreshDeviceList = function (treeNode){
				var url;
				if(treeNode.type == "11"){//编码设备
					url = appath+"/admin/devices.do";
				}
				$.ajax({
					type:"POST",
					url:url,
					data:{"act":"search", "search":$("#search").val(), "nodeCode":treeNode.getParentNode().id},
					success:function(msg){
						$("#maincontext").html(msg);
					},
					error:function(msg){
						alert(msg);
					}
				});
			},
			//对设备进行重新排序
			orderDevice = function (treeId,treeNode,targetNode,moveType){
				var nextNode = treeNode.getNextNode();
				var preNode = treeNode.getPreNode();
				$.ajax({
					type:"POST",
					url:zTree.setting.other.appath+"/admin/ztree.do",
					data:"act=order&tdeviceid="+targetNode.id+"&movdeviceid="+treeNode.id+"&movetype="+moveType,
					success:function(msg){
						if(msg=="false"){
							if(nextNode){
								zTreeArray[treeId].moveNode(nextNode,treeNode,"prev");
							}else if(preNode){
								zTreeArray[treeId].moveNode(pretNode,treeNode,"next");
							}
							alert(msg);
						}else{
							refreshDeviceList(treeNode);
						}
					},
					error:function(msg){

						alert(msg);
					}
				});

			},
			getTreeId = function(obj){
				while(obj){
					if(obj.id){
						var zTreeObj= $(obj).find("#"+obj.id+"_zTree");
						if(zTreeObj.size()>0)return zTreeObj.attr("id");
					}
					obj = obj.parentNode;
				}
			},
			//查询树
			 ztreeSearch = function (){
				var treeId = getTreeId(this);
				var zTree = zTreeArray[treeId];
				var searchKey = $("#"+zTree.setting.other.treeDivId+" input[name='searchKey']");
				searchKey = searchKey.val()?searchKey.val():"";
				zTree.setting.data.simpleData.enable = true;
				zTree.setting.async.enable = false;
				$.ajax({
					type:"POST",
					dataType:"json",
					url:zTree.setting.other.appath+"/admin/ztree.do",
					data:{"act":"search", "keyType":zTree.setting.other.searchKeyType,"key":searchKey, "type":zTree.setting.async.otherParam.type},
					success:function(msg){
						zTree = $.fn.zTree.init($("#"+zTree.setting.other.treeDivId+" ul"),zTree.setting,msg);
						zTree.setting.data.simpleData.enable = false;
						zTree.setting.async.enable = true;
					},
					error:function(msg){
						alert(msg);
					}
				});
			},
			//确定选择
			ok = function (){
				var treeId = getTreeId(this);
				var zTree = zTreeArray[treeId];
				var selectedNode = zTree.getCheckedNodes();
				try{
					if(handleCheckedNodes(selectedNode)){//回调函数，对于选择节点的处理方式
						$("#"+zTree.setting.other.treeDivId).hide();
					//	$("#maskIfame").hide();
					}
				}catch(e){
					
				}
			},
			//取消
			cancel = function(){
				var treeId = getTreeId(this);
				var zTree = zTreeArray[treeId];
				$("#"+zTree.setting.other.treeDivId).hide();
				//$("#maskIfame").hide();
			},
			//重置
			reset = function(){
				var treeId = getTreeId(this);
				var zTree = zTreeArray[treeId];
				zTree.checkAllNodes(false);
			},
			//移动窗口
			moveDiv = function(e){
				var treeId = getTreeId(this);
				var zTree = zTreeArray[treeId];
				var obj = $("#"+zTree.setting.other.treeDivId+" .devTreeDiv-title")[0];
				var dragX = 0;
			    var dragY = 0;
			    var isCatchDiv;
			    var moveDiv = document.getElementById(zTree.setting.other.treeDivId);
			    obj.onmousedown = function(e){
					var evt = e||event;
					isCatchDiv = true;
					var x=parseInt(evt.clientX)+document.body.scrollLeft;
					var y=parseInt(evt.clientY)+document.body.scrollTop;
					dragX=x-parseInt(moveDiv.style.left);
					dragY=y-parseInt(moveDiv.style.top);
				};

				obj.onmousemove = function(e){
					var evt = e||event;
					if(isCatchDiv){
						var left = parseInt(evt.clientX)+document.body.scrollLeft-dragX;
						var top = parseInt(evt.clientY)+document.body.scrollTop-dragY;
			            moveDiv.style.left = parseInt(evt.clientX)+document.body.scrollLeft-dragX + "px";
			            moveDiv.style.top = parseInt(evt.clientY)+document.body.scrollTop-dragY + "px";
			            window.status = "X:"+moveDiv.style.left+";Y:"+moveDiv.style.top;
					}
				};
				document.onmouseup = function(){
					isCatchDiv = false;
				};
				obj.onmousedown(e);
			},
			deviceZtreeTools = {
				zTree:zTree	
			};
			return deviceZtreeTools;
		}	
	};
	changeTreeNodesStatus =  function(myTree,treeNode){//改变节点的选择状态
		var jsonNodes = myTree.setting.other.jsonNodes;
		if(treeNode){//选择节点时加载子节点
			changeChildNodesStatus(myTree,treeNode);

		}else{//重新加载树，或者树切换时重新勾选树		
			
			var nodes = myTree.getNodes();
			
			unCheckAllNode(nodes, myTree);
			
			initRootNode(nodes, jsonNodes);
			
			if(nodes.length>0){
				changeChildNodesStatus(myTree, nodes[0]);	
			}

		}
	},
	unCheckAllNode = function(nodes,myTree){//将所有的节点更新为未选状态
		var nodeArr = myTree.transformToArray(nodes)
		if(nodeArr){
			for(var i=0; i<nodeArr.length; i++){
				changeNodeCheck(nodeArr[i],false,false);
			}
		}
	},
	initRootNode = function(nodes,jsonNodes){//初始化根节点，因根节点没有父节点，所以在缓存中根节点的父定义为“root”，需要做特殊处理
		
		if(jsonNodes&&nodes.length>0){//缓存中有选择时需要初始化
			
			for(var i=0; i<jsonNodes.length; i++){
				if(jsonNodes[i].id=="root"){//缓存中存在根节点的选择
					if(jsonNodes.length>1){//除了根节点选择外，还有其它节点的勾选情况
						changeNodeCheck(nodes[0],true,true);
					}else{//只有根节点的选择信息
						changeNodeCheck(nodes[0],false,true);
					}	
					return;
				}
			}
			if(jsonNodes.length>0){//根节点未选择，其它节点有选择
				changeNodeCheck(nodes[0],true,false);
			}
		}
	},
	getParentCheck = function(myTree,treeNode){
		var jsonNodes = myTree.setting.other.jsonNodes;
		var nodeChecked = treeNode.checked;
		if(nodeChecked){
			return true;
		}
		if(!nodeChecked && treeNode.getParentNode()){//根据缓存中treeNode是否选择来判断
			for(var j=0; j<jsonNodes.length; j++){
				if(jsonNodes[j].id==treeNode.getParentNode().id){
					var value = eval(jsonNodes[j].value);
					for(var i=0; i<value.length; i++){
						if(treeNode.id==value[i].id){
							return value[i].checked;
						}					
					}
					break;
				}
			}
			return getParentCheck(myTree,treeNode.getParentNode());
		}
	},
	changeChildNodesStatus = function(myTree, treeNode){//改变treeNode子节点的状态
		var jsonNodes = myTree.setting.other.jsonNodes;
		if(jsonNodes==null || jsonNodes=="" || jsonNodes.length==0){//缓存中没有选择信息
			changeNodeCheck(treeNode,false,false);
			return ;
		}
		if(isRootChecked(jsonNodes)){//根节点选择，做特殊处理
			changeNodeCheck(treeNode,false,true);
		}
		var children = treeNode.children;
		if(!children){//treeNode不存在子节点
			return;
		}
		
		for(var i=0; i<children.length; i++){//改变所有孙子的节点状态
			changeChildNodesStatus(myTree, children[i]);
		}
		
		var checkedValue;
		for(var j=0; j<jsonNodes.length; j++){//获取缓存中treeNode的第一级子节点的选择信息
			if(jsonNodes[j].id==treeNode.id){
				checkedValue = eval(jsonNodes[j].value);
				break;
			}
		}
		
		if(checkedValue){//存在缓存中treeNode的第一级子节点的选择信息
			for(var i=0; i<children.length; i++){//根据缓存中treeNode的第一级子节点的选择信息，来确认treeNode的子节点是否要勾选
				var isExit = true;
				for(var k=0; k<checkedValue.length;k++){
					if(checkedValue[k].id==children[i].id){//缓存中存在
						changeNodeCheck(children[i], false, checkedValue[k].checked);
						isExit = false;
						break;
					}
				}
				if (isExit) {
					var pChecked = getParentCheck(myTree,treeNode);
					if(pChecked){
						changeNodeCheck(children[i],false,true);
					}
				}	
			}
		}else{//缓存中没有treeNode子节点的选择信息，并且treeNode选择
			var parentChecked = getParentCheck(myTree,treeNode);
			if(parentChecked){
				changeNodeCheck(treeNode,false,true);
				for(var i=0; i<children.length; i++){
					changeNodeCheck(children[i],false,true);
				}				
			}	
		}
		
		for(var i=0; i<children.length; i++){//根据缓存中treeNode的第一级以外的其它子节点的选择信息，来确认treeNode的子节点是否要半勾选
			if(!children[i].id.startWith("001")){//非组织节点，不需要半勾选
				break;
			}
			for(var k=0; k<jsonNodes.length;k++){
				if(jsonNodes[k].id.startWith(children[i].id)){//缓存中treeNode的第一级以外的其它子节点的选择信息存在，需要半选
					children[i].halfCheck = true;
					myTree.updateNode(children[i]);
					break;
				}
			}
		}
	},
	isRootChecked = function(jsonNodes){//初始化根节点状态
		if(jsonNodes&&jsonNodes.length==1&&jsonNodes[0].id=="root"){
			return true;
		}
		return false;
	},
	changeNodeCheck = function(treeObj, halfCheck, checked){//更新节点选择状态，ztree的更新节点性能差
		treeObj.halfCheck = halfCheck;
		treeObj.checked = checked;
		var newClass = "checkbox_"+checked+(halfCheck?"_part":"_full")
		$("#"+treeObj.tId+"_check").removeClass();
		$("#"+treeObj.tId+"_check").addClass("button chk "+newClass);
	},
	
	/**
	changeTreeNodeStatus =  function(myTree,treeNode){//改变节点的选择状态
		
		var jsonNodes = myTree.setting.other.jsonNodes;
		
		if(jsonNodes==null || jsonNodes==""){
			treeNode.halfCheck = false;
			treeNode.checked = false;
			myTree.updateNode(treeNode);
			return ;
		}
		
		var childNode = null;
		var parentNode = treeNode.getParentNode();
		var pId = "";
		if(parentNode){
			pId = parentNode.id;
			treeNode.checked = parentNode.checked;
		}
		
		for(var i=0; i<jsonNodes.length; i++){var a = jsonNodes[i].pId;
			if((jsonNodes[i].id==treeNode.id)&&(jsonNodes[i].pId==pId)){//存在节点
				treeNode.checked = jsonNodes[i].checked;
			}else if(jsonNodes[i].pId.startWith(treeNode.id)
					||jsonNodes[i].pPid.startWith(treeNode.id)){//存在子节点
				treeNode.halfCheck = true;
			}
		}
		if(treeNode.checked||treeNode.halfCheck){
			myTree.updateNode(treeNode);
		}
	},
	changeTreeNodesStatus =  function(myTree){//改变节点的选择状态
		var jsonNodes = myTree.setting.other.jsonNodes;
		myTree.checkAllNodes(false);
		//取消强制半选状态
		var halfCheckNodes = myTree.getNodesByParam("halfCheck",true);
		if(halfCheckNodes){
			for(var index=0;index<halfCheckNodes.length;index++){
				halfCheckNodes[index].halfCheck=false;
				myTree.updateNode(halfCheckNodes[index]);
			}
		}
		
		if(jsonNodes==null || jsonNodes==""){
			return ;
		}
		var map=new Map();//重复勾选判断
		var nodeId;
		var nodePId;
		var treeNode;
		for(var i=0; i<jsonNodes.length; i++){
			nodeId = jsonNodes[i].id;
			nodePId = jsonNodes[i].pId;
			treeNode = myTree.getNodeByParam("id", nodeId);
			if(!treeNode){//不存在，则为下级节点，勾选上级节点
				if(map.get(nodePId)){
					continue;
				}
				//在两颗相同类型的树之间切换，由于前端数据结构和后台的不同，即使节点存在且被选择
				//也需要去判断其下级节点是否有勾选去掉的，有，则要将其上级半选。
				for(var j=nodePId.length-3;j>=0;j=j-3){
					if(map.get(nodePId)){
						break;
					}
					var tempNode = myTree.getNodeByParam("id", nodePId);
					if(tempNode && ((tempNode.checked && !jsonNodes[i].checked)|| (!tempNode.checked && jsonNodes[i].checked)) ){
						tempNode.halfCheck = true;
						//tempNode.checked = true;
						myTree.updateNode(tempNode);
						map.put(nodePId,true);
						break;
					}
					nodePId=nodePId.substring(0,j);
				}
			}else{//存在
				treeNode.checked = jsonNodes[i].checked;
				//map.put(nodeId,true);
				myTree.updateNode(treeNode,true);
			}
		}
	},
	*/
	checkNode = function(jsonNodes,treeNode){
		treeNode.halfCheck = false;
		var isNeedAdd = true;
		var parentIndex;
		var checkValue = null;
		var parentNode = treeNode.getParentNode();
		var pId = "";
		if(parentNode){
			pId = parentNode.id;
		}else{//操作的是根节点，做特殊处理
			if(treeNode.checked){
				return [{"id":"root","value":eval("["+JSON.stringify({"id":treeNode.id,"checked":treeNode.checked,"name":treeNode.name,"type":treeNode.type,"pId":pId,"pPid":pPid,"icon":treeNode.icon})+"]")}]
			}else{
				return [];
			}
		}
		if(jsonNodes){//已有选择信息
			for(var i=0; i<jsonNodes.length; i++){
				if(jsonNodes[i].id==parentNode.id){//缓存中已存在选择的父节点
					parentIndex = i;
					checkValue = eval(jsonNodes[i].value);//父节点下所有子节点的选择情况
					//var isExist = false;
					for(var j=0; j<checkValue.length; j++){
						if(treeNode.id==checkValue[j].id){//缓存中存在子节点的选择信息
							checkValue[j].checked = treeNode.checked;//&&!parentNode.type.length==4
							if((parentNode.checked&&checkValue[j].checked)
									||(!parentNode.checked&&!checkValue[j].checked)){//父选择，子选择，可删除子节点的选择信息。或者，父未选择，子未选择，可删除子节点的未选择信息
								checkValue.splice(j,1);
								j--;
							}
							jsonNodes[i].value = JSON.stringify(checkValue);
							isNeedAdd = false;
							break;
						}
					}
					if(checkValue.length==0){//父节点下所有节点的选择状态都已删除，删除该父节点
						jsonNodes.splice(i,1);
						i--;
					}
				}else if(jsonNodes[i].id.startWith(treeNode.id)){//删除全部选择节点的子节点的选择信息
					jsonNodes.splice(i,1);i--;
				}
			}
		}else{
			jsonNodes = [];
		}
		if(isNeedAdd){//缓存中不存在
			var pPid = "";
			var parentParentNode = null;
			if(parentNode){
				parentParentNode = parentNode.getParentNode();
			}
			if(parentParentNode){
				pPid = parentParentNode.id;
			}
			var jsonNodeValue = {"id":treeNode.id,"checked":treeNode.checked,"name":treeNode.name,"type":treeNode.type,"pId":pId,"pPid":pPid,"icon":treeNode.icon};
			if(checkValue!=null){
				checkValue.push(jsonNodeValue)
				jsonNodes[parentIndex].value = checkValue;
				
			}else{
				jsonNodes.push({"id":pId,"value":eval("["+JSON.stringify(jsonNodeValue)+"]")})
			}
		}
		return jsonNodes;
	},
	callBackOnNodeCreated = function(event, treeId, treeNode){
		if(treeNode.parentTId==null&&treeNode.isParent==false){//对不存在子节点的根节点做处理
			$("#"+treeNode.tId+"_switch").attr("class","level1 switch bottom_docu");
		}
		if(treeNode.id=="next"){
			//将checkbox隐藏不可用，否则影响全局的checkbox勾选
			treeNode.nocheck=true;
			zTreeArray[treeId].updateNode(treeNode);
			var parentNode=treeNode.getParentNode();	
			$("#"+treeNode.tId+"_check").remove();
			var nextNodeA = $("#" + treeNode.tId + "_a");
			var nextNodeSpan = $("#" + treeNode.tId + "_span");
			var nextNodeIcon = $("#" + treeNode.tId + "_ico");
			nextNodeSpan.html("");
			nextNodeIcon.css("background", 'url("include/img/tree/down.png")');
			nextNodeA.click(function(){
				var nodes = zTreeArray[treeId].getSelectedNodes();
			//	if(!parentNode.childNo)parentNode.childNo=0;
				parentNode.childNo = treeNode.nodeNo;
			//	zTreeArray[treeId].removeNode(treeNode);
				zTreeArray[treeId].setting.async.otherParam.searchKey = "";
				//zTreeArray[treeId].reAsyncChildNodes(parentNode,"refresh");
				setTimeout(function ()
					{
						zTreeArray[treeId].reAsyncChildNodes(parentNode,"refresh");
						zTreeArray[treeId].selectNode(nodes[0]);
		            }, 250);

			});	
		}else if(treeNode.id=="pre"){
			//将checkbox隐藏不可用，否则影响全局的checkbox勾选
			treeNode.nocheck=true;
			zTreeArray[treeId].updateNode(treeNode);
			var parentNode=treeNode.getParentNode();	
			$("#"+treeNode.tId+"_check").remove();
			var preNodeA = $("#" + treeNode.tId + "_a");
			var preNodeSpan = $("#" + treeNode.tId + "_span");
			var preNodeIcon = $("#" + treeNode.tId + "_ico");
			preNodeSpan.html("");
			preNodeIcon.css("background", 'url("include/img/tree/up.png")');
			preNodeA.click(function(){
				var nodes = zTreeArray[treeId].getSelectedNodes();
				parentNode.childNo = treeNode.nodeNo;
			//	zTreeArray[treeId].removeNode(treeNode);
				zTreeArray[treeId].setting.async.otherParam.searchKey = "";
				setTimeout(function ()
	            	{
						zTreeArray[treeId].reAsyncChildNodes(parentNode,"refresh");	    
						zTreeArray[treeId].selectNode(nodes[0]);
	                }, 250);
				    			
			});
		}
	};
})(jQuery);






