---
name: unit-testing
description: Use this skill when writing, editing, or reviewing unit tests — Vitest, @testing-library/vue, composable testing, XCTest. Covers testing philosophy (happy and unhappy paths), what to skip (methods that delegate to @lewishowles/helpers), and meaningful assertions over snapshots. Always apply when working in *.test.js files or when the user mentions tests, specs, or coverage. For end-to-end tests, see the e2e-testing skill if present.
related-skills:
  - code-style
  - vue
  - typescript
---

# Unit testing

## General

- Over-test for robustness: happy/unhappy paths, valid/invalid variants
- Meaningful assertions over snapshots for volatile content
- Separate test setup from assertions like separating variables from logic in JS

## Vue & Vitest

- Vitest; unit-test computed properties and heavily-used methods
- Skip tests for methods delegating to `@lewishowles/helpers`
- Component testing: focus on user interactions and state changes
- For composables: test reactive state, side effects, lifecycle hooks

### Component test structure

```typescript
// src/components/form-input/form-input.test.js
import { describe, it, expect } from 'vitest';
import { mount } from '@vue/test-utils';
import FormInput from './form-input.vue';

describe('FormInput', () => {
	it('updates modelValue on input', async () => {
		const wrapper = mount(FormInput, {
			props: {
				modelValue: 'initial',
			},
		});

		const input = wrapper.find('input');
		await input.setValue('updated');

		expect(wrapper.emitted('update:modelValue')).toBeTruthy();
		expect(wrapper.emitted('update:modelValue')[0]).toEqual(['updated']);
	});

	it('displays error slot when provided', () => {
		const wrapper = mount(FormInput, {
			slots: {
				error: 'This field is required',
			},
		});

		expect(wrapper.text()).toContain('This field is required');
	});

	it('disables input when disabled prop is true', async () => {
		const wrapper = mount(FormInput, {
			props: {
				disabled: true,
			},
		});

		const input = wrapper.find('input');
		expect(input.attributes('disabled')).toBeDefined();
	});
});
```

### Composable test structure

```typescript
// src/composables/use-form.test.js
import { describe, it, expect } from 'vitest';
import { useForm } from './use-form';

describe('useForm', () => {
	it('initializes with default values', () => {
		const { data } = useForm({
			name: '',
			email: '',
		});

		expect(data.value).toEqual({ name: '', email: '' });
	});

	it('updates field values', () => {
		const { data, updateField } = useForm({
			name: '',
			email: '',
		});

		updateField('name', 'Lewis');

		expect(data.value.name).toBe('Lewis');
	});

	it('validates required fields', () => {
		const { validate, errors } = useForm(
			{ name: '' },
			{
				name: { required: true },
			}
		);

		validate();

		expect(errors.value.name).toBeDefined();
	});

	it('resets form to initial state', () => {
		const { data, updateField, reset } = useForm({
			name: 'Lewis',
		});

		updateField('name', 'Jane');
		reset();

		expect(data.value.name).toBe('Lewis');
	});
});
```

**File colocation**: place test file next to the component or composable using `.test.js` extension. Vitest discovers and runs them automatically.
