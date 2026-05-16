---
name: unit-testing
description: >
  Use this skill when writing, editing, or reviewing unit tests — Vitest, @testing-library/vue, composable testing, XCTest. Covers testing philosophy (happy and unhappy paths), what to skip (methods that delegate to @lewishowles/helpers), and meaningful assertions over snapshots. Always apply when working in *.test.js files or when the user mentions tests, specs, or coverage. For end-to-end tests, see the e2e-testing skill if present.
related-skills:
  - code-style
  - vue
  - typescript
---

# Unit testing

## General

- Over-test: happy/unhappy paths, valid/invalid variants
- Meaningful assertions over snapshots for volatile content
- For JSON or other serialised output, assert decoded structure or user-visible behaviour unless key order is part of a deliberately implemented contract. Do not test object key order from standard encoders because it is often not guaranteed and leads to brittle failures.
- Separate test setup from assertions like separating variables from logic in JS
- Keep imports at the top of the file
- Test and group names are capitalised, human-readable, and self-contained; method/computed names may stay exact
- Group tests by collection, e.g. "Initialisation", "Computed", "Methods"
- **Do not** write interaction tests in unit tests; those are covered in Playwright/Cypress tests
- **Do not** run tests, as consuming the output is token-heavy

## Vue & Vitest

- Vitest; unit-test computed properties and heavily-used methods
- Skip tests for methods delegating to `@lewishowles/helpers`
- Component testing: focus on rendered state, props, slots, and emitted events
- Composables: test reactive state, side effects, lifecycle hooks

### Component test structure

- Top level component group names should use `kebab-case` to refer to the component (e.g. `form-input`, not `FormInput`)

```javascript
// src/components/form-input/form-input.test.js
import { mount } from "@vue/test-utils";
import { describe, expect, test } from "vitest";

import FormInput from "./form-input.vue";

describe("form-input", () => {
	describe("Initialisation", () => {
		test("Displays the provided model value", () => {
			const wrapper = mount(FormInput, {
				props: {
					modelValue: "Initial value",
				},
			});

			expect(wrapper.find("input").element.value).toBe("Initial value");
		});
	});

	describe("States", () => {
		test("Disables the input when disabled is true", () => {
			const wrapper = mount(FormInput, {
				props: {
					disabled: true,
				},
			});

			expect(wrapper.find("input").attributes("disabled")).toBeDefined();
		});
	});

	describe("Slots", () => {
		test("Displays the error slot when provided", () => {
			const wrapper = mount(FormInput, {
				slots: {
					error: "This field is required",
				},
			});

			expect(wrapper.text()).toContain("This field is required");
		});
	});
});
```

### Composable test structure

```javascript
// src/composables/use-form.test.js
import { describe, expect, test } from "vitest";

import { useForm } from "./use-form";

describe("useForm", () => {
	describe("Initialisation", () => {
		test("Initialises with default values", () => {
			const { data } = useForm({
				name: "",
				email: "",
			});

			expect(data.value).toEqual({ name: "", email: "" });
		});
	});

	describe("Computed", () => {
		test("hasErrors is true when errors are present", () => {
			const { errors, hasErrors } = useForm({
				name: "",
			});

			errors.value.name = "Name is required";

			expect(hasErrors.value).toBe(true);
		});
	});

	describe("Methods", () => {
		test("Updates field values", () => {
			const { data, updateField } = useForm({
				name: "",
				email: "",
			});

			updateField("name", "Lewis");

			expect(data.value.name).toBe("Lewis");
		});

		test("Validates required fields", () => {
			const { validate, errors } = useForm(
				{ name: "" },
				{
					name: { required: true },
				}
			);

			validate();

			expect(errors.value.name).toBeDefined();
		});

		test("Resets the form to its initial state", () => {
			const { data, updateField, reset } = useForm({
				name: "Lewis",
			});

			updateField("name", "Jane");
			reset();

			expect(data.value.name).toBe("Lewis");
		});
	});
});
```

### Helper test structure

```javascript
import { describe, expect, test } from "vitest";
import get from ".";


describe("get", () => {
  test("Resets the form to its initial state", () => {
    const sampleObject = {
      name: "Sophie",
      profiles: {
        linkedIn: "linkedin/sophie",
        behance: {
          icon: "behance.icon",
          url: "behance/sophie",
        },
      },
    };

    test("Retrieves a top level property", () => {
      expect(get(sampleObject, "name")).toBe("Sophie");
    });
  });
});
```

### Testing input types

When a function expects a specific input type, test invalid types together with `test.for()` so coverage stays strict without repeating the same assertion.

Start with the shared invalid-type list:

```javascript
test.for([
	["boolean (true)", true],
	["boolean (false)", false],
	["number (positive)", 1],
	["number (negative)", -1],
	["number (NaN)", NaN],
	["string (non-empty)", "string"],
	["string (empty)", ""],
	["object (non-empty)", { property: "value" }],
	["object (empty)", {}],
	["array (non-empty)", [1, 2, 3]],
	["array (empty)", []],
	["null", null],
	["undefined", undefined],
])("Rejects invalid <something>: %s", ([, input]) => {
	expect(myHelper(input)).toBe("...");
});
```

Then remove any cases that should pass for the helper being tested. For example, when testing `isNonEmptyObject`, remove:

```javascript
["object (non-empty)", { property: "value" }],
```

because that is the valid case.

### File co-location

Place test file next to component, composable, or test using `.test.js` extension. Vitest discovers and runs automatically.
