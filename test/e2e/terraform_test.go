package e2e

import (
	"fmt"
	"testing"

	test_helper "github.com/Azure/terraform-module-test-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestExamples(t *testing.T) {
	examples := []string{}
	for _, example := range examples {
		e := example
		t.Run(fmt.Sprintf("%s_for_each", e), func(t *testing.T) {
			testExample(t, e, true)
		})
		t.Run(fmt.Sprintf("%s_count", e), func(t *testing.T) {
			testExample(t, e, false)
		})
	}
}

func testExample(t *testing.T, exampleRelativePath string, useForEach bool) {
	vars := map[string]interface{}{
		"use_for_each": useForEach,
	}
	test_helper.RunE2ETest(t, "../../", exampleRelativePath, terraform.Options{
		Upgrade: true,
		Vars:    vars,
	}, func(t *testing.T, output test_helper.TerraformOutput) {
		_, ok := output["identity_experience_framework_application_id"].(string)
		assert.True(t, ok)
	})
}
