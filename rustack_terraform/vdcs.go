package rustack_terraform

import (
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/validation"
)

func (args *Arguments) injectCreateVdc() {
	args.merge(Arguments{
		"project_id": {
			Type:        schema.TypeString,
			Required:    true,
			ForceNew:    true,
			Description: "id of the Project",
		},
		"name": {
			Type:     schema.TypeString,
			Required: true,
			ValidateFunc: validation.All(
				validation.NoZeroValues,
				validation.StringLenBetween(1, 100),
			),
			Description: "name of the VDC",
		},
		"tags": newTagNamesResourceSchema("tags of the VDC"),
	})
}

func (args *Arguments) injectContextVdcById() {
	args.merge(Arguments{
		"vdc_id": {
			Type:        schema.TypeString,
			Required:    true,
			ForceNew:    true,
			Description: "id of the VDC",
		},
	})
}

func (args *Arguments) injectContextVdcByIdForData() {
	args.merge(Arguments{
		"vdc_id": {
			Type:        schema.TypeString,
			Required:    true,
			Description: "id of the VDC",
		},
	})
}

func (args *Arguments) injectContextGetVdc() {
	args.merge(Arguments{
		"name": {
			Type:        schema.TypeString,
			Optional:    true,
			Computed:    true,
			Description: "name of the vdc",
		},
		"id": {
			Type:        schema.TypeString,
			Optional:    true,
			Computed:    true,
			Description: "id of the VDC",
		},
	})
}

func (args *Arguments) injectResultVdc() {
	args.merge(Arguments{
		"id": {
			Type:        schema.TypeString,
			Computed:    true,
			Description: "id of the VDC",
		},
		"name": {
			Type:        schema.TypeString,
			Computed:    true,
			Description: "name of the VDC",
		},
		"hypervisor": {
			Type:        schema.TypeString,
			Computed:    true,
			Description: "name of the Hypervisor",
		},
		"hypervisor_type": {
			Type:        schema.TypeString,
			Computed:    true,
			Description: "type of the Hypervisor",
		},
	})
}

func (args *Arguments) injectResultListVdc() {
	s := Defaults()
	s.injectResultVdc()

	args.merge(Arguments{
		"vdcs": {
			Type:     schema.TypeList,
			Computed: true,
			Elem: &schema.Resource{
				Schema: s,
			},
		},
	})
}
