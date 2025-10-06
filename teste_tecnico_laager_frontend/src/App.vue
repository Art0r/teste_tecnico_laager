<script setup lang="ts">
import Navbar from "@/common/components/Navbar.vue";
</script>

<template>
  <header>
    <Navbar />
  </header>
  <main class="main">
    <RouterView />
  </main>
  <footer>
  </footer>
</template>

<style scoped lang="scss">
  body, html {
    padding: 0;
    margin: 0;
  }

  .main {
    width: 100vw;
    min-height: 90vh;
    margin-top: 10vh;
  }

</style>