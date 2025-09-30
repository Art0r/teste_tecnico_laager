<script setup lang="ts">
import type {ParticipantsStatistics} from "@/common/types/participant.ts";
  const props = defineProps<{
    statistics: ParticipantsStatistics | null
  }>();
</script>

<template>
  <pre>Total de Votos:
    <b>{{props.statistics?.total_votes}}</b>
  </pre>
  <div v-for="participant in props.statistics?.participants">
    <pre>Nome: {{ participant.name }}</pre>
    <pre>Votos: {{ participant.total_votes }}</pre>
  </div>
</template>

<style scoped lang="scss">

</style>