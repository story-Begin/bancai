/**
 * 项目公共js
 * @param $
 */
(function($) {
	/**
	 * JSON格式的一行数据，拉平成一行数组数据 {key: value} ==> [value]
	 * @param {Object} rowJson  key，value形式的一行json数据
	 * @param {Boolean} transport 传送到后台数据库的数据的默认值处理
	 * @return {Array} JSON对象拉平后的数组数据
	 */
	EiBlock.prototype.getMappedArray = function(rowJson, transport) {
		var metas = this.getBlockMeta().getMetas(); // {eiColumn.name: eiColumn}
		var row = [];
		for ( var colName in metas) {
			if (metas.hasOwnProperty(colName)) {
				var pos = this.getColumnPos(colName);
				if (pos >= 0) {
					if (transport) {
						if (metas[colName].type === "N") {
							// 2017-09-17 JSON Lib 丢失精度的问题, N类型的数据到后台还是String JavaBean 处理
							row[pos] = (rowJson[colName] || 0) + "";
						} else {
							row[pos] = $.isNumeric(rowJson[colName]) ? (rowJson[colName] + "")
									: (rowJson[colName] || "") + "";
						}
					} else {
						row[pos] = rowJson[colName];
					}
				}
			}
		}
		return row;
	};

	kendo.ui.Tooltip.fn._closeButtonClick = function(e) {
		e.preventDefault();
		this.hide(true);
	};

	kendo.ui.Tooltip.fn.hide = (function(hide) {
		return function(isClick) {
			if (this.options.filter === '.pscs-tooltip') {
				if (!!isClick) {
					hide.call(this);
				}
			} else {
				hide.call(this);
			}
		}
	})(kendo.ui.Tooltip.fn.hide);

	/**
	 * 移除页面选择记录
	 */
	kendo.ui.Grid.prototype.removeCheckedRows = function(isValid, msg) {
		var that = this;
		var rows = that.getCheckedRows();
		var handlers = IPLAT.Util.unbindHandlers(that.dataSource, "change");
		var length = rows.length;
		if (isValid) {

			if (length > 0) {
				SLMSUtil.confirm("确定对勾选中的[" + rows.length + "]条数据做\""
						+ defaultIfEmpty(msg, "移除") + "\"操作?", {
					ok : function() {
						for (var i = 0; i < length; i++) {
							that.dataSource.remove(rows[i])
						}
					}
				});
			} else {
				WindowUtil({
					'title' : "提示!",
					"content" : "<div class='kendo-del-message'>请先勾选数据!</div>"
				});
			}

		} else {
			for (var i = 0; i < length; i++) {
				that.dataSource.remove(rows[i])
			}
		}
		IPLAT.Util.bindHandlers(that.dataSource, "change", handlers);
		that.dataSource.trigger("change", {
			action : "remove",
			items : rows
		});

	};

	/**
	 * 移除页面选择记录
	 */
	kendo.ui.Grid.prototype.removedDataItems = function(isValid, msg) {
		var that = this;
		var rows = that.getDataItems();
		var length = rows.length;
		if (isValid) {

			SLMSUtil.confirm("确定对[" + rows.length + "]条数据做\""
					+ defaultIfEmpty(msg, "移除") + "\"操作?", {
				ok : function() {
					for (var i = 0; i < length; i++) {
						that.dataSource.remove(rows[i])
					}
				}
			});

		} else {
			for (var i = 0; i < length; i++) {
				that.dataSource.remove(rows[i])
			}
		}

	};

	/**
	 * 验证是否有选中记录
	 */
	kendo.ui.Grid.prototype.isSelectedRows = function(msg) {
		var that = this;
		var rowsdata = that.getCheckedRows();
		if (rowsdata.length > 0) {
			return true;
		} else {
			WindowUtil({
				'title' : "操作提示",
				"content" : "<div class='kendo-del-message'>"
						+ defaultIfEmpty(msg, '请选中记录再操作') + "</div>"
			});
			return false;
		}

	};

	var defaultIfEmpty = function(value, defaultValue) {
		if (!IPLAT.isAvailable(value)) {
			return defaultValue;
		} else {
			return value;
		}
	}

	var SLMSColorbox = SLMSColorbox || {};
	SLMSColorbox = {
		popWindow : "",
		paraData : {},
		callbackName : null,
		open : function(parameter) {
			if (typeof (parameter["width"]) == "undefined") {
				parameter["width"] = "90%";
			}
			if (typeof (parameter["height"]) == "undefined") {
				parameter["height"] = "90%";
			}
			if (typeof (parameter["title"]) == "undefined") {
				parameter["title"] = "";
			}
			if (typeof (parameter["paraData"]) !== "undefined") {
				this.paraData = parameter["paraData"];
			}
			if (typeof (parameter["modal"]) == "undefined") {
				parameter["modal"] = true;
			}

			var actions = [];
			if (!parameter["actions"]) {
				actions = [ "Close" ]
			}

			var divhtml = $("#SLMSColorboxWin");
			if (divhtml.length > 0) {

			} else {
				var divStr = "<div id='SLMSColorboxWin'> </div>";
				$("body").append(divStr);
				divhtml = $("#SLMSColorboxWin");
			}

			divhtml.kendoWindow({
				content : "",
				iframe : true,
				width : parameter["width"],
				height : parameter["height"],
				modal : parameter["modal"],
				pinned : true,
				actions : actions,
				visible : false
			/*
			 * , open: onOpen, position: { top: "<%=top%>", left: "<%=left%>" }
			 */
			});

			if (parameter.params) {
				parameter["href"] = this.setParams(parameter.params,
						parameter["href"]);
			}

			var href = parameter["href"];
			var index = href.indexOf("?")
			if (index == -1) {
				var inx = href.indexOf("&");
				if (inx > 0) {
					href = replacePos(href, (inx + 1), "?");
				}
			} else {

			}
			parameter["href"] = href;

			popWindow = divhtml.data("kendoWindow");
			popWindow.setOptions({
				open : function() {
					popWindow.refresh({
						url : parameter["href"]
					});
				}
			})

			$("#SLMSColorboxWin_wnd_title").html(parameter["title"]);
			this.callbackName = parameter["callbackName"];
			popWindow.content("");
			popWindow.center().open();

			/*
			 * window.setValueCallback = function(rowData, win) { //
			 * popWindow.close(); parameter["callbackName"](rowData, win); //
			 * eval(this.callbackName + "('" + rowData + "','" + win + // "')"); }
			 */
		},

		setValueCallback : function(rowData, win) {
			if (this.callbackName) {
				this.callbackName(rowData, win);
			}
			// eval(this.callbackName + "('" rowData + "','" + win + "')"); },
		},
		close : function() {
			popWindow.close();
		},
		/**
		 * [setParams 设置多个参数]
		 *
		 * @param {Object}
		 *            obj
		 * @param {String}
		 *            url [default:location.href]
		 * @return {[String|Boolean]}
		 */
		setParams : function(obj, url) {
			var result = url || '';
			result = url + "&" + $.param(obj);

			/* if (Object.prototype.toString.call(obj) !== '[object Object]') return false;
			for (var name in obj) {
			    result = this.setParam(name, obj[name], result);
			}*/
			return result;
		},
		/**
		 * [setParam 设置单个参数]
		 *
		 * @param {String}
		 *            name
		 * @param {String|Number}
		 *            val
		 * @return {String|Boolean}
		 */
		setParam : function(name, val, url) {
			if (typeof name !== 'string')
				return false;
			if (!url)
				url = window.location.href;
			var _name = name.replace(/[\[\]]/g, '\\$&');
			var value = name + '=' + encodeURIComponent(val);
			var regex = new RegExp(_name + '=[^&]*');
			var urlArr = url.split('#');
			var result = '';

			if (regex.exec(url)) {
				result = url.replace(regex, value);
			} else {
				result = urlArr[0] + '&' + value + (urlArr[1] || '');
			}

			return result;
		}

	};

	var replacePos = function(strObj, pos, replacetext) {
		var str = strObj.substr(0, pos - 1) + replacetext
				+ strObj.substring(pos, strObj.length);
		return str;
	}

	var blinkBorder = function(elements) {
		var es = elements;
		$.each(es, function(i, e) {
			$(e).addClass("large red button");
		});
		setTimeout(function() {
			$.each(es, function(i, e) {
				$(e).removeClass("large red button");
			});
		}, 2000);
	}

	/**
	 * @param {String}
	 *            grid_ids
	 *            girdid,如果是多个用逗号隔开，"result,resultAdd",如果只提交form表单填""(必传)
	 * @param {String}
	 *            service_name 后台service（必传）
	 * @param {String}
	 *            method_name 后台方法 （必传）
	 * @param {Boolean}
	 *            isRefreshre 是否刷新页面数据（false/true） （必传）
	 * @param {Function}
	 *            callback 回调函数 （选传）
	 * @param {Object}
	 *            eiinfo 传入的eiinfo信息（选传）
	 * @param {Boolean}
	 *            isGetForm 是否传入form表单的数据（false/true） （选传）默认传
	 */
	var submitGridsData = function(grid_ids, service_name, method_name,
			isRefreshre, callback, eiinfo, isGetForm) {

		// 点击的按钮
		var $activeElement = $(document.activeElement);
		var _IPLAT = IPLAT;
		$activeElement.attr("disabled", true);
		_IPLAT.progress($("body"), true);

		var eiInfo = __eiInfo
		var info = eiinfo || new EiInfo();
		// console.log(this);
		if (!IPLAT.isAvailable(isGetForm) || isGetForm === true) {
			info.setByNodeObject(document.body);
		}

		if (IPLAT.isAvailable(grid_ids)) {
			var _grid_ids = grid_ids.split(",");
			for (var j = 0, count = _grid_ids.length; j < count; j++) {
				var grid_id = _grid_ids[j];
				/* 将选中的Grid数据转成BLOCK并放到info里 start */
				info.addBlock(checkedRows2Block(grid_id));
				/* 将选中的Grid数据转成BLOCK并放到info里 end */
			}
		}
		// 调用请求 onSuccess 成功回掉函数
		EiCommunicator
				.send(
						service_name,
						method_name,
						info,
						{
							onSuccess : function(ei) {
								// //console.log(ei);

								/*
								 * var msgHtml = kendo
								 * .template($("#msg-template").html()) ( {
								 * msgKey : ei.getMsgKey() || "", msg :
								 * ei.getMsg(), detailMsg : ei.getDetailMsg()
								 * });
								 */
								if (ei.getStatus() >= 0) {
									if (isRefreshre) {
										// //console.log(EiConstant.EF_CUR_FORM_ENAME);
										try {
											IPLAT
													.fillNode(
															document
																	.getElementById(eiInfo.extAttr[EiConstant.EF_FORM_ENAME]),
															ei);
										} catch (e) {
											// TODO: handle exception
										}
										if (IPLAT.isAvailable(grid_ids)) {
											for (var j = 0, count = _grid_ids.length; j < count; j++) {
												// SLMSUtil.grid_setData(ei.getBlock(_grid_ids[j]),_grid_ids[j]);
												window[_grid_ids[j] + 'Grid']
														.setEiInfo(ei);
												// grid_setEiInfo(window[_grid_ids[j]
												// + 'Grid'],ei);
												// var
												// grid=$("#ef_grid_"+_grid_ids[j]).data("kendoGrid");//获取kendoGrid

												/* grid.setEiInfo(ei); */
												// grid.trigger("onSuccess.IPLAT",
												// {eiInfo: ei})
											}
										}
									}
									if (ei.getStatus() == 0) {
										NotificationUtil(ei, 'warning');
									} else {
										NotificationUtil(ei);
									}
									if (typeof callback === 'function') {
										callback(ei);
									}
								} else {
									NotificationUtil(ei, "error");
									if (typeof callback === 'function') {
										callback(ei);
									}
								}
								$activeElement.attr("disabled", false);
								_IPLAT.progress($("body"), false);
								// onFail 表示失败回掉函数
							},
							onFail : function(ei) {
								// 发生异常
								$activeElement.attr("disabled", false);
								_IPLAT.progress($("body"), false);
								// console.log(ei);
								NotificationUtil("操作失败，原因[" + ei + "]", "error");
							}
						});

	};

	/***************************************************************************
	 * 钩选中的数据转 Block
	 */
	var checkedRows2Block = function(grid_id) {
		var resultGrid = window[grid_id + 'Grid'];
		var columns = resultGrid.columns;
		var dateColumns = _.filter(columns,
				function(column) {
					return column.editType === "date"
							|| column.editType === "datetime";
				});
		var eiblock = new EiBlock(grid_id);
		var rowsDate = resultGrid.getCheckedRows();
		for (var int = 0; int < rowsDate.length; int++) {
			if (int == 0) {
				for ( var key in rowsDate[0].toJSON()) {
					var eColumn = new EiColumn(key);
					eiblock.getBlockMeta().addMeta(eColumn);
				}
			}
			var model = rowsDate[int];
			$
					.each(
							dateColumns,
							function(index, dateColumn) {
								var field = dateColumn.field, dateFormat = dateColumn.dateFormat;
								model[field] = kendo.toString(model[field],
										dateFormat);// 日期转String
							});

			eiblock.addRow(eiblock.getMappedArray(model, true));
		}
		var showCount = eiblock.get(EiConstant.SHOW_COUNT) || "true";
		eiblock.set(EiConstant.SHOW_COUNT, showCount);
		eiblock.set(EiConstant.LIMIT, resultGrid.dataSource['_pageSize']);
		// eiblock.set(EiConstant.OFFSET, resultGrid.dataSource['_skip']);
		// 默认查询第一页
		eiblock.set(EiConstant.OFFSET, 0);

		return eiblock;
	}

	/***************************************************************************
	 * 全部的数据转 Block
	 */
	var dataItemsBlock = function(grid_id) {
		var resultGrid = window[grid_id + 'Grid'];
		var columns = resultGrid.columns;
		var dateColumns = _.filter(columns,
				function(column) {
					return column.editType === "date"
							|| column.editType === "datetime";
				});
		var eiblock = new EiBlock(grid_id);
		var rowsDate = resultGrid.getDataItems();
		for (var int = 0; int < rowsDate.length; int++) {
			if (int == 0) {
				for ( var key in rowsDate[0].toJSON()) {
					var eColumn = new EiColumn(key);
					eiblock.getBlockMeta().addMeta(eColumn);
				}
			}
			var model = rowsDate[int];
			$
					.each(
							dateColumns,
							function(index, dateColumn) {
								var field = dateColumn.field, dateFormat = dateColumn.dateFormat;
								model[field] = kendo.toString(model[field],
										dateFormat);// 日期转String
							});

			eiblock.addRow(eiblock.getMappedArray(model, true));
		}
		var showCount = eiblock.get(EiConstant.SHOW_COUNT) || "true";
		eiblock.set(EiConstant.SHOW_COUNT, showCount);
		eiblock.set(EiConstant.LIMIT, resultGrid.dataSource['_pageSize']);
		// eiblock.set(EiConstant.OFFSET, resultGrid.dataSource['_skip']);
		// 默认查询第一页
		eiblock.set(EiConstant.OFFSET, 0);

		return eiblock;
	}

	var grid_setEiInfo = function(resultId, eiInfo) {
		var r, n = null, result = resultId;
		if (resultId.constructor == String) {
			var grid = $("#ef_grid_" + result).data("kendoGrid");
			if (grid) {
				result = grid;
				n = grid.dataSource;

			} else {
				return;
			}
		} else {
			n = result.dataSource;
		}
		var eiBlock = eiInfo.getBlock(resultId.getBlockId());
		if (eiBlock) {
			var limit = eiBlock.get(EiConstant.LIMIT) || 0;
			var offset = eiBlock.get(EiConstant.OFFSET) || 0;
			result.setEiInfo(eiInfo);
			/*
			 * if (e === t) { if (n._data) for (r = 0; r < n._data.length; r++)
			 * n._data.at(r); return n._data }
			 */
			/* n._page=3, */
			n._skip = offset, n._take = limit, n._process(n._data);
		}

	}

	var grid_setData = function(eiBlock, dataSource) {
		var count = 0, e = [], limit = 0, offset = 0;
		if (eiBlock != undefined) {
			count = eiBlock.get(EiConstant.COUNT) || 0;
			limit = eiBlock.get(EiConstant.LIMIT) || 0;
			offset = eiBlock.get(EiConstant.OFFSET) || 0;
			e = eiBlock.getMappedRows();
		}
		var r, n = null;
		if (dataSource.constructor == String) {
			var grid = $("#ef_grid_" + dataSource).data("kendoGrid");
			if (grid) {
				n = grid.dataSource;

			} else {
				return;
			}
		} else {
			n = dataSource;
		}
		/*
		 * if (e === t) { if (n._data) for (r = 0; r < n._data.length; r++)
		 * n._data.at(r); return n._data }
		 */
		/* n._page=3, */
		n._skip = offset;
		n._take = limit;

		n._detachObservableParents();
		n._data = n._observe(e);
		n._pristineData = e.slice(0);
		n._storeData();
		n._ranges = [];
		n._addRange(n._data);
		n._total = count; // n._data.length,
		n._pristineTotal = n._total;
		n._process(n._data);

	}

	var grid_radioCheckbox = function(gridId, element, isChecked) {
		var checked = isChecked || $(element)[0].checked, gridInstance = $(
				gridId).data("kendoGrid");
		$(gridId).find("input.check-one:checked").each(
				function(index, element) {
					var checked = false, $element = $(element), uid = $element
							.val(), checkedIndex = _.indexOf(
							gridInstance._checkedRows, uid);
					element.checked = checked;
					var $contentRow = $(gridId).find(
							".k-grid-content tr[data-uid=" + uid + "]");
					$element.closest("tr").removeClass(
							"i-state-selected k-state-selected");
					$contentRow
							.removeClass("i-state-selected k-state-selected");
					$element.trigger("unchecked");
					if (checkedIndex >= 0) {
						gridInstance._checkedRows.splice(uid, 1);
					}
				})
		var $element = $(element), uid = $element.val(), gridInstance = $(
				gridId).data("kendoGrid"), checkedIndex = _.indexOf(
				gridInstance._checkedRows, uid);
		var $contentRow = $(gridId).find(
				".k-grid-content tr[data-uid=" + uid + "]");
		$(element)[0].checked = checked;
		if (checked) {
			$element.closest("tr")
					.addClass("i-state-selected k-state-selected");
			$contentRow.addClass("i-state-selected k-state-selected");
			$element.trigger("checked");
			if (checkedIndex < 0) {
				gridInstance._checkedRows.push(uid);
			}
		} else {
			$element.closest("tr").removeClass(
					"i-state-selected k-state-selected");
			$contentRow.removeClass("i-state-selected k-state-selected");
			$element.trigger("unchecked");
			if (checkedIndex >= 0) {
				gridInstance._checkedRows.splice(uid, 1);
			}
		}
	}

	var PsConfirm = function(message, callback, title) {
		var content = kendo.template($("#del-template").html())({
			message : message,
			ok : '确定',
			cancel : '取消'
		});
		WindowUtil({
			title : title || "提示!",
			content : content,
			ok : function() {
				var that = this;
				if (typeof callback.ok === 'function') {
					callback.ok(this);
				}
				;
				that.data("kendoWindow").close();

			},
			cancel : function() {
				var that = this;
				if (typeof callback.cancel === 'function') {
					callback.cancel(this);
				}
				;
				that.data("kendoWindow").close();
			}
		})
	}

	var block2String = function(regionId) {
		// 分为三种情形 分别处理 eiInfo 的 attr 中，block 的 rows 中，block 的 attr 中
		var ei = new EiInfo();
		ei.setByNode(regionId);
		var blocks = ei.getBlocks();
		var block, blockAttr, rows, row, result = {};
		for ( var blockName in blocks) {
			if (blocks.hasOwnProperty(blockName)) {
				block = blocks[blockName];
				blockAttr = block.getAttr();
				// 处理 block 中的 attr
				for ( var blockAttrName in blockAttr) {
					if (!_.isEmpty(blockAttr[blockAttrName])) {
						result[blockName + "-" + blockAttrName] = blockAttr[blockAttrName];
					}
				}

				// 处理block 中的 rows
				rows = block.getMappedRows();
				for (var i = 0, length = rows.length; i < length; i++) {
					row = rows[i];
					for ( var rowName in row) {
						if (!_.isEmpty(row[rowName])) {
							result[blockName + "-" + i + "-" + rowName] = row[rowName];
						}
					}
				}
			}
		}

		// 处理 eiInfo中 attr
		var attr = ei.getAttr();

		for ( var attrName in attr) {
			if (!_.isEmpty(attr[attrName])) {
				result[attrName] = attr[attrName];
			}
		}

		// 这里根据SLMS项目组需求，把select 多选下拉框里面的值中存在',' 替换为 ';'
		var nodes = $("#" + regionId).find("select");
		for (var i = 0, id, length = nodes.length; i < length; i++) {
			id = $(nodes[i]).attr('id');
			if (!!result[id]) {
				result[id] = result[id].replace(/,/g, ';');
			}
		}

		return result;
	};

	var submitGrid = function(grid_ids, service_name, method_name, parameter) {

		var obj = {
			isGetForm : true,
			isRefreshre : true,
			isProgress : true,
			isAlldata : false
		};

		$.extend(obj, parameter);

		var _IPLAT = IPLAT;
		var $activeElement = $(document.activeElement);
		$activeElement.attr("disabled", true);

		// 点击的按钮
		if (obj.isProgress) {
			_IPLAT.progress($("body"), true);
		}

		// var grid_ids=obj.gridIds;
		var eiInfo = __eiInfo
		var info = obj.eiinfo || new EiInfo();

		if (!IPLAT.isAvailable(obj.isGetForm) || obj.isGetForm === true) {
			info.setByNodeObject(document.body);
		}

		if (IPLAT.isAvailable(grid_ids)) {
			var _grid_ids = grid_ids.split(",");
			for (var j = 0, count = _grid_ids.length; j < count; j++) {
				var grid_id = _grid_ids[j];
				/* 将选中的Grid数据转成BLOCK并放到info里 start */
				if (obj.isAlldata) {
					info.addBlock(dataItemsBlock(grid_id));
				} else {
					info.addBlock(checkedRows2Block(grid_id));
				}

				/* 将选中的Grid数据转成BLOCK并放到info里 end */
			}
		}
		// 调用请求 onSuccess 成功回掉函数
		EiCommunicator
				.send(
						service_name,
						method_name,
						info,
						{
							onSuccess : function(ei) {
								// //console.log(ei);

								/*
								 * var msgHtml = kendo
								 * .template($("#msg-template").html()) ( {
								 * formEname :
								 * ei.extAttr[EiConstant.EF_CUR_FORM_ENAME] ||
								 * "", msg : ei.getMsg(), msgKey :
								 * ei.getMsgKey(), detailMsg : ei.getDetailMsg()
								 * });
								 */
								if (ei.getStatus() >= 0) {
									if (obj.isRefreshre) {
										// //console.log(EiConstant.EF_CUR_FORM_ENAME);
										try {
											IPLAT
													.fillNode(
															document
																	.getElementById(eiInfo.extAttr[EiConstant.EF_FORM_ENAME]),
															ei);
										} catch (e) {
											// TODO: handle exception
										}
										if (IPLAT.isAvailable(grid_ids)) {
											for (var j = 0, count = _grid_ids.length; j < count; j++) {
												SLMSUtil
														.grid_setData(
																ei
																		.getBlock(_grid_ids[j]),
																_grid_ids[j]);
												// var
												// grid=$("#ef_grid_"+_grid_ids[j]).data("kendoGrid");//获取kendoGrid

												/* grid.setEiInfo(ei); */
												// grid.trigger("onSuccess.IPLAT",
												// {eiInfo: ei})
											}
										}
										NotificationUtil(ei);

									}

								} else {
									NotificationUtil(ei, "error");
								}

								$activeElement.attr("disabled", false);
								if (obj.isProgress) {
									_IPLAT.progress($("body"), false);
								}
								if (typeof obj.onSuccessCallback === 'function') {
									obj.onSuccessCallback(ei);
								}

								// onFail 表示失败回掉函数
							},
							onFail : function(ei) {
								// 发生异常
								$activeElement.attr("disabled", false);
								if (obj.isProgress) {
									_IPLAT.progress($("body"), false);
								}
								// console.log(ei);
								NotificationUtil("操作失败，原因[" + ei + "]", "error");
							}
						});

	};

	/*
	 * SLMSUtil.attachManagement( { docPath:__eiInfo.get("pathValue"), docTag:
	 * __eiInfo.get("docTagValue"), codeset:
	 * "pscs.pm.DocAttr1,pscs.pm.DocAttr2,pscs.pm.DocAttr3", docTypeId: "SUP",
	 * "inqu_status-0-businessKey01":$("#head-0-bpoId").val(),
	 * "inqu_status-0-businessKey02":"uw", "inqu_status-0-remark":"附件属性实例" } );
	 */

	var attachManagement = function(params) {

		SLMSColorbox.open({
			href : "PMJPD4?methodName=initLoad",
			title : "<div style='text-align: center;'>附件管理</div>",
			width : "90%",
			height : "90%",
			params : params

		});
	};

	/**
     * 自动填充DOM结点各输入域的内容
     * @private
     * @param {Object} node     DOM结点对象
     * @param {EiInfo} eiInfo   数据
     * @里面分出两个方法 一个是对日期的处理，一个是原来的处理逻辑
     */
    IPLAT.fillNode = function (node, eiInfo) {
    	dataOperate(node, eiInfo);
    	
    	fillNodeOriginal(node,eiInfo);
    };
    
    /**
     * 对查询区域进行日期处理
     * @private
     * @param {Object} node     DOM结点对象
     * @param {EiInfo} eiInfo   数据
     */
    dataOperate = function (node, eiInfo){
    	if (node.tagName === "INPUT" && node.type !== "button") {
        	if (isAvailable(node.name)) {
				cellValue = eiInfo.get(node.name);
			}

			if (typeof cellValue === 'undefined') {
				return;
			}

            if ($(node).data("role") === "dropdownlist") {
            } else if ($(node).data("role") === "datepicker" || $(node).data("role") === "datetimepicker") {
                var isDatePicker = $(node).data("role") === "datepicker",
                    datePicker = isDatePicker ? $(node).data("kendoDatePicker") : $(node).data("kendoDateTimePicker"),
                    dateOptions = datePicker.options,
                    formats = [dateOptions.format],
                    paseFormats = dateOptions.parseFormats;

                formats = formats.concat(paseFormats).concat(_.values(IPLAT.FORMAT));

                var dateValue = kendo.parseDate(cellValue, formats);
                datePicker.value(dateValue);
                datePicker.trigger("change");

            } else if ($(node).data("role") === "autocomplete") {} else {}
        } else if (node.tagName === "TEXTAREA") {} else if (node.tagName === "SELECT") {} else {
            for (var i = 0; i < node.childNodes.length; i++) {
                try {
                	dataOperate(node.childNodes[i], eiInfo);
                } catch (exception) {
                }
            }
        }
    };
    
    /**
     * 自动填充DOM结点各输入域的内容   原有处理逻辑
     * @private
     * @param {Object} node     DOM结点对象
     * @param {EiInfo} eiInfo   数据
     */
    fillNodeOriginal = function(node, eiInfo){
    	 var cellValue;

         if (node.tagName === "INPUT" && node.type !== "button") {
         	if (isAvailable(node.name)) {
 				cellValue = eiInfo.get(node.name);
 			}

 			if (typeof cellValue === 'undefined') {
 				return;
 			}
//             cellValue = eiInfo.get(node.name);
 //
//             if (!isAvailable(cellValue)) {
//                 // 根据node.name 无法在eiInfo中获取值
//                 return;
//             }

             // EFInput格式化 绑定EiInfo中的value的处理
             // if ($(node).attr('data-role') === "formatInput") {
             //     var $textField = $("#" + node.name + "_textField");
             //     $textField.val(cellValue);
             //     $textField.blur();
             // }

             if ($(node).data("role") === "dropdownlist") {
                 $(node).data("kendoDropDownList").value(cellValue);
                 $(node).data("kendoDropDownList").trigger("change");
             } else if ($(node).data("role") === "datepicker" || $(node).data("role") === "datetimepicker") {
                 var isDatePicker = $(node).data("role") === "datepicker",
                     datePicker = isDatePicker ? $(node).data("kendoDatePicker") : $(node).data("kendoDateTimePicker"),
                     dateOptions = datePicker.options,
                     formats = [dateOptions.format],
                     paseFormats = dateOptions.parseFormats;

                 formats = formats.concat(paseFormats).concat(_.values(IPLAT.FORMAT));

                 var dateValue = kendo.parseDate(cellValue, formats);
                 datePicker.value(dateValue);
                 datePicker.trigger("change");

             } else if ($(node).data("role") === "autocomplete") {
                 $(node).data("kendoAutoComplete").value(cellValue);
                 $(node).data("kendoAutoComplete").trigger("change");
             } else {
                 IPLAT.EFInput.value($(node), cellValue);
                 // node.value = cellValue;
             }
         } else if (node.tagName === "TEXTAREA") {
             cellValue = eiInfo.get(node.name);
             if (cellValue === null) {
                 return;
             }
             IPLAT.EFInput.value($(node), cellValue);

             // $(node).text(cellValue).val(cellValue);
         } else if (node.tagName === "SELECT") {
             cellValue = eiInfo.get(node.name);
             if($(node).data("role") === "multiselect") {
                 $(node).data("kendoMultiSelect").value(cellValue);
                 $(node).data("kendoMultiSelect").trigger("change");
             }
         } else {
             for (var i = 0; i < node.childNodes.length; i++) {
                 try {
                	 fillNodeOriginal(node.childNodes[i], eiInfo);
                 } catch (exception) {
                 }
             }
         }
    }


	// export 到全局作用域 window对象
	$.extend(window, {
		SLMSColorbox : SLMSColorbox,
		SLMSUtil : {
			grid_setData : grid_setData,
			blinkBorder : blinkBorder,
			submitGridsData : submitGridsData,
			grid_radioCheckbox : grid_radioCheckbox,
			confirm : PsConfirm,
			checkedRows2Block : checkedRows2Block,
			attachManagement : attachManagement,
			submitGrid : submitGrid,
			block2String : block2String
		}
	});
})(window.jQuery);