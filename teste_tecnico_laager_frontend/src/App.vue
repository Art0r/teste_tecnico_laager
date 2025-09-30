<script setup lang="ts">
import Navbar from "@/common/components/Navbar.vue";
</script>

<template>
  <header>
    <Navbar />
  </header>
  <main>
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
</style>