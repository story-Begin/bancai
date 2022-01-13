Vue.component('organizationequipmenttree', {
    template: `
<div id="tree">
<el-input clearable style="width:90%; padding-left:5%;  margin-top: 10px;" size="mini" 
    placeholder="请输入【名称】进行搜索" v-model="filterText"></el-input>
    <el-tree
            ref="organizationTreeRef"
            style="height: 100%;"
            class="tree"
            lazy
            highlight-current
            :load="getOrganizationEquipmentTree"
            node-key="id"
            :props="defaultProps"
            :default-expanded-keys="[0]"
            @node-click="handleOrganizationTreeClick">
                <span class="custom-tree-node" slot-scope="{ node, data }" style="font-size: 13px;">
                    <span>
                        <i :class="data.icon"></i> {{ data.organizationName }}
                    </span>          
                </span>
            </el-tree>
</div>`,
    data: function () {
        return {
            // 树
            defaultProps: {
                label: 'organizationName',
                children: 'children',
                icon: 'nodeType',
                isLeaf: function (data, node) {
                    if (data && data.leaf) {
                        return true
                    }
                    return false
                }
            },
            isInit: false,
            highlight: true,
            defaultExpandedKeys: [0],
            organizationTreeLoading: false,
            queryContent: '',
            rootNode: {
                id: 0,
                organizationName: '马钢（合肥）板材',
                isLeaf: false,
                icon: 'magang-font icon-changfang' //厂房
            },
            loading: false,
            revertTreeData: [],
            filterText: null,
            currentNode: null,
            treeNodeList: [],
            editTreeNodeList: [],
        }
    },

    watch: {
        filterText(val) {
            if (!val) {
                const node = this.$refs.organizationTreeRef.getNode(this.currentNode.data.id);
                node.loaded = false;
                node.expand();
            } else {
                this.treeNodeList = this.editTreeNodeList;
                this.treeNodeList = this.treeNodeList.filter(it => (it.data.organizationName).indexOf(val) > -1);
                let nodes = this.$refs.organizationTreeRef.getNode(this.currentNode.key);
                nodes.childNodes = this.treeNodeList;
            }
        }
    },

    methods: {
        /**
         * 机构树
         */
        getOrganizationEquipmentTree(node, resolve) {
            const queryData = {}
            if (node.level == 0) {
                this.getEquipmentCount();
                return resolve([this.rootNode]);
                this.organizationTreeLoading = true
            } else {
                queryData.id = node.data.id
            }
            axios.post(ctx + '/backstage/equipment/organization/organizationEquipmentTree', queryData)
                .then(res => {
                    res.data.data.forEach(it => {
                        if (it.deviceType === 0) {
                            if (it.status == 1) {
                                it.icon = "magang-font icon-qiangji" // 枪机
                            } else {
                                it.icon = "magang-font icon-qiangji2" // 离线
                            }
                        } else if (it.deviceType == 1) {
                            if (it.status == 1) {
                                it.icon = "magang-font icon-banqiuji" // 球机
                            } else {
                                it.icon = "magang-font icon-banqiuji2" // 离线
                            }
                        } else if ( it.deviceType == 2) {
                            if (it.status == 1) {
                                it.icon = "magang-font icon-banqiuji" // 球机
                            } else {
                                it.icon = "magang-font icon-banqiuji2" // 离线
                            }
                        }
                    })
                    resolve(res.data.data);
                    //this.initCurrentKey(res.data.data)
                    this.organizationTreeLoading = false;
                }).catch(err => {
                console.log(err);
                this.organizationTreeLoading = false;
            })
        },

        /**
         * 统计设备总数
         */
        getEquipmentCount() {
            let formData = new FormData();
            formData.append("id", this.rootNode.id);
            axios.post(ctx + '/backstage/equipment/organization/getCameraDataCount', formData)
                .then(res => {
                    console.log(res)
                    this.rootNode.organizationName = this.rootNode.organizationName
                        + "【" + res.data.data.onLine + "/" + res.data.data.sumOnLine + "】";
                }).catch(err => {
                console.log("设备总数获取异常！")
                console.log(err)
            })
        },

        /*initCurrentKey(node) {
            if (!this.isInit) {
                this.isInit = true
                if (node && node.length > 0) {
                    this.$nextTick(() => {
                        this.$refs.organizationTreeRef.setCurrentKey(node[0].id);
                });
                    this.handleOrganizationTreeClick(node)
                }
            }
        },*/


        handleOrganizationTreeClick(node, data) {
            this.currentNode = data;
            setTimeout(() => {
                this.treeNodeList = data.childNodes;
                this.editTreeNodeList = data.childNodes;
            }, 500);
            this.$emit('organization-equipment-tree-click', node);
        }
    }

});









