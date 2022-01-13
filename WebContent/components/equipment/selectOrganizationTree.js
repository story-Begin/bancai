Vue.component('select-organization-tree', {
    template: `
<div id="tree">
    <el-select v-model="currentOrganizationName" style="width:100%;" size="mini" placeholder="请选择组织" clearable @clear="clearHandle">
        <el-option :value="currentOrganizationName" :label="currentOrganizationName" 
            style="height:180px; overflow: auto;background-color:#001f6b; ">
          <el-tree
            lazy
            style="height: 100%; width:100%;"
            highlight-current
            ref="organizationTreeRef"
            :load="getOrganizationTree"
            :default-expand-all="expandAll"
            :props="defaultProps"
            node-key="id"
            :show-checkbox="checkbox"
            size="mini"
            @node-click="handleOrganizationTreeClick">
                <span class="custom-tree-node" slot-scope="{ node, data }" style="font-size: 13px;">
                     <span>
                        <i :class="data.icon"></i> {{ data.organizationName }}
                     </span>             
                </span>
          </el-tree>
        </el-option>
    </el-select>

</div>`,
    props: {
        organization: {type: Number},
        expandAll: {type: Boolean},
        currentNode: {type: Number},
        checkbox: {type: Boolean},
        organizationName: {type: String}
    },
    watch: {
        currentNode(newVal) {
            this.deviceOrganizationId = newVal
            this.$refs.organizationTreeRef.setCurrentKey(newVal);
            const node = this.$refs.organizationTreeRef.getNode(newVal)
            if (node != null) {
                this.currentOrganizationName = node.data.organizationName
            }
        },
    },
    data: function () {
        return {
            deviceOrganizationId: null,
            currentOrganizationName: '未分组',
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
                icon: 'magang-font icon-changfang'
            },
            loading: false,
            revertTreeData: [],

        }
    },

    methods: {
        /**
         * 机构树
         */
        getOrganizationTree(node, resolve) {
            const queryData = {}
            if (node.level == 0) {
                return resolve([this.rootNode]);
                this.organizationTreeLoading = true
            } else {
                queryData.id = node.data.id
            }
            axios.post(ctx + '/backstage/equipment/organization/organizationTree', queryData)
                .then(res => {
                    resolve(res.data.data)
                    this.organizationTreeLoading = false
                }).catch(err => {
                console.log(err)
                this.organizationTreeLoading = false
            })
        },

        clearHandle() {
            this.deviceOrganizationId = null;
            this.currentOrganizationName = null;
            this.$emit('func', '')
        },

        handleOrganizationTreeClick(node) {
            this.deviceOrganizationId = node.id;
            this.currentOrganizationName = node.organizationName
            this.$emit('organization-tree-click', node)
        }
    }
});









