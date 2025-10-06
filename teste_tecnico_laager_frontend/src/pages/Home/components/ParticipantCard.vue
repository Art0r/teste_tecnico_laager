<script setup lang="ts">
  import type {Participant} from "@/common/types/participant.ts";
  import {useFetch} from "@vueuse/core";
  import Swal from "sweetalert2";
  import {watch} from "vue";

  const props = defineProps<{
      participant: Participant
  }>();

  const { isFetching, isFinished, error, execute } = useFetch(`/api/participants/${props.participant.id}/upvote`, {
    method: "PATCH",
    cache: "no-store",
    priority: "high",
  }, {
    immediate: false,
  });

  watch(error, async (newVal, oldVal) => {
    if (newVal === oldVal) return;

    await Swal.fire({
      text: "Ocorreu um erro ao votar, tente novamente mais tarde!",
      icon: "error",
      timer: 1000,
      showConfirmButton: false
    });

  });

  watch(isFinished, async (newVal, oldVal) => {
    if (newVal === oldVal) return;

    await Swal.fire({
      text: "Voto computado com sucesso",
      icon: "success",
      timer: 1000,
      showConfirmButton: false
    });
  });

</script>

<template>
  <div class="participant-card" disabled={{isFetching}}}>
    <template v-if="isFetching">
      <pre>Loading</pre>
    </template>
    <template v-else-if="error">
      <pre>{{error}}</pre>
    </template>
    <template v-else>
      <div @click="() => execute()">
        <pre><b>{{ participant.name }}</b></pre>
      </div>
    </template>
  </div>
</template>

<style scoped lang="scss">

  .participant-card {
    border: 2px solid black;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-width: fit-content;
    max-width: 300px;
    width: 300px;
    padding: 1dvh 1dvw;
    font-size: 1.2vw;
    background-color: #DADAE6;
    transform: scale(1);
    transition: transform 0.3s ease;

    &:hover {
      cursor: pointer;
      transform: scale(1.05);
      background-color: #D0D0DB
    }

    .participant-card-text {
      font-size: 1.2vw;
      text-align: center;
    }

  }
</style>