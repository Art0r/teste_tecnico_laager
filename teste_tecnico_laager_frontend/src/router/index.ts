import { createRouter, createWebHistory } from 'vue-router'
import Home from "@/pages/Home/Home.vue";
import Admin from "@/pages/Admin/Admin.vue";


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
      { path: '/', component:  Home },
      { path: '/admin', component: Admin },
  ],
})

export default router
