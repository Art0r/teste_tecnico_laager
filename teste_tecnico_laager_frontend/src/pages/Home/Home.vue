<script setup lang="ts">
  import {useFetch} from "@vueuse/core";
  import type {Participant} from "@/common/types/participant.ts";
  import ParticipantCard from "@/pages/Home/components/ParticipantCard.vue";

  const { isFetching, error, data } = useFetch("/api/participants", {
    method: "GET",
  }).json<Participant[]>();

</script>

<template>
  <section class="participants-home">
    <template v-if="isFetching">
      <p>Loading</p>
    </template>
    <template v-else-if="error">
      <p>{{error}}</p>
    </template>
    <template v-else>
      <div class="participants-list">
        <ParticipantCard
            v-for="participant in data"
            :key="participant.id"
            :participant="participant"
        />
      </div>
    </template>
  </section>
</template>

<style scoped lang="scss">

  .participants-home {
    width: 100dvw;
    height: 100dvh;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }

  .participants-list {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    gap: 1rem;
    align-items: center;
    justify-content: center;
    padding: 1rem;
  }
</style>
