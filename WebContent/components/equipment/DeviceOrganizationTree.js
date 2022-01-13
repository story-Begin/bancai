Vue.component('organization_tree', {
    template: `
<div id="tree">
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
                children:
                    'children',
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
        }

    },

    methods: {
        /**
         * 机构树
         */
        getOrganizationEquipmentTree(node, resolve) {
            const queryData = {}
            if (node.level == 0) {
                return resolve([this.rootNode]);
                this.organizationTreeLoading = true
            } else {
                queryData.id = node.data.id
            }
            axios.post(ctx + '/backstage/equipment/organization/organizationTree', queryData).then(res => {
                resolve(res.data.data)
                this.initCurrentKey(res.data.data)
                this.organizationTreeLoading = false
            }).catch(err => {
                console.log(err)
                this.organizationTreeLoading = false
            })
        },

        initCurrentKey(node) {
            if (!this.isInit) {
                this.isInit = true
                if (node && node.length > 0) {
                    this.$nextTick(() => {
                        this.$refs.organizationTreeRef.setCurrentKey(node[0].id);
                    });
                    this.handleOrganizationTreeClick(node)
                }
            }
        },

        handleOrganizationTreeClick(node) {
            this.$emit('organization-click', node)
        }
    }

});
