import { describe, it, expect } from 'vitest'

import { mount } from '@vue/test-utils'
import Home from "@/pages/Home/Home.vue";

describe('Home', () => {
  it('mounts renders properly', () => {
    const wrapper = mount(Home)
    expect(wrapper.text()).toContain('You did it!')
  })
})
