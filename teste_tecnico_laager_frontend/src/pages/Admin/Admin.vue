<script setup lang="ts">
import {useFetch} from "@vueuse/core";
import type {ParticipantsStatistics} from "@/common/types/participant.ts";
import AdminPanel from "@/pages/Admin/components/AdminPanel.vue";

const { isFetching, error, data } = useFetch("/api/participants/statistics", {
  method: "GET",
}).json<ParticipantsStatistics>();

</script>

<template>
  <section class="participants-admin">
    <template v-if="isFetching">
      <p>Loading</p>
    </template>
    <template v-else-if="error">
      <p>{{error}}</p>
    </template>
    <template v-else>
      <AdminPanel :statistics="data"/>
    </template>
  </section>
</template>

<style scoped lang="scss">
  .participants-admin {
    width: 100dvw;
    height: 100dvh;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }
</style>