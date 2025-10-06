<script setup lang="ts">
import {useAdminStore} from "@/stores/admin.ts";
const store = useAdminStore();
</script>

<template>
  <div class="panel">
    <pre class="item">Total de Votos: <b>{{store.getParticipantsStatistics.total_votes}}</b></pre>
    <pre class="item">Votos por hora: <b>{{store.getParticipantsStatistics.votes_per_hour}}</b></pre>
    <pre class="item">Participantes:</pre>
    <div class="participant" v-for="participant in store.getParticipantsStatistics.participants">
      <pre class="item">ID: {{ participant.id }}</pre>
      <pre class="item">Nome: {{ participant.name }}</pre>
      <pre class="item">Votos: {{ participant.votes_count }}</pre>
      <hr class="dotted">
    </div>
  </div>
</template>

<style scoped lang="scss">
  hr.dotted {
    border-top: 3px dotted #bbb;
  }

  .panel {
    padding: 20px;
    border: 1px solid black;
    border-radius: 10px;
    background-color: #C4CF99;

    .item {
      font-size: 30px;
    }
  }
</style>