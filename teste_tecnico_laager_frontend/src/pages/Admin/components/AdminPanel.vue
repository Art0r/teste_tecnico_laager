<script setup lang="ts">
import {useAdminStore} from "@/stores/admin.ts";
const store = useAdminStore();
</script>

<template>
  <pre>Total de Votos:
    <b>{{store.getParticipantsStatistics.total_votes}}</b>
  </pre>
  <pre>Votos por hora:
    <b>{{store.getParticipantsStatistics.votes_per_hour}}</b>
  </pre>
  <div v-for="participant in store.getParticipantsStatistics.participants">
    <pre>Nome: {{ participant.name }}</pre>
    <pre>Votos: {{ participant.votes_count }}</pre>
  </div>
</template>

<style scoped lang="scss">

</style>