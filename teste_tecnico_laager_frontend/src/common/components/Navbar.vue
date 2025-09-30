<script setup lang="ts">
import { useRoute } from 'vue-router'
const route = useRoute();
</script>

<template>
  <nav class="navbar">
    <div class="navbar-content">
      <ul>
        <li>
          <RouterLink
              :class="[route.path === '/' ? 'route selected': 'route' ]"
              to="/">Home</RouterLink>
        </li>
        <li>
          <RouterLink
            :class="[route.path === '/admin' ? 'route selected' : 'route' ]"
            to="/admin">Admin</RouterLink>
        </li>
      </ul>
    </div>
  </nav>
</template>

<style scoped lang="scss">
  .navbar {
    width: 100%;
    height: 10vh;
    position: absolute;
    top: 0;
    left: 0;
    z-index: 1000;
    background-color: #9DBD30;

    .navbar-content {
      max-width: 1200px;
      margin: 0 auto;
      height: 100%;
      display: flex;
      align-items: center;
      justify-content: center;

      ul {
        display: flex;
        list-style: none;
        gap: 2rem;
        padding: 0 2rem;

        .route {
          padding: 1.5vh 1.5vw;
          background-color: #A2DCFD;
          border-radius: 5px;
          color: grey;
          cursor: pointer;
          font-size: 20px;
          text-decoration: none;

          &:hover {
            opacity: 0.8;
          }

          &.selected {
            background-color: #00AEEF;
            color: #fff;
          }

        }
      }
    }
  }
</style>