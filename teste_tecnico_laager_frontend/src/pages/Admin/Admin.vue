<script setup lang="ts">
import { onMounted, onUnmounted } from "vue";
import {useAdminStore} from "@/stores/admin.ts";
import {webSocketBehaviorsOnMessage} from "@/pages/Admin/actions/websocket.ts";
import AdminPanel from "@/pages/Admin/components/AdminPanel.vue";

let websocket: WebSocket | null = null;
const channel: String = "StatisticsChannel";
const store = useAdminStore();

onUnmounted(() => {
  if (websocket) {
    websocket.close();
  }
});

onMounted(() => {
  websocket = new WebSocket('/api/websocket');

  websocket.onopen = () => {
    console.log(`Connecting to WebSocket - ${channel}`);

    const subscribeMessage = {
      command: "subscribe",
      identifier: JSON.stringify({
        channel: channel
      })
    };

    websocket?.send(JSON.stringify(subscribeMessage));
  };

  websocket.onmessage = (event) => webSocketBehaviorsOnMessage(event, store);

  websocket.onerror = (error) => {
    console.error(`WebSocket error - ${channel}:`, error);
  };

  websocket.onclose = () => {
    console.log(`WebSocket disconnected - ${channel}`);
  };
});

</script>

<template>
  <section class="participants-admin">
    <AdminPanel />
  </section>
</template>

<style scoped lang="scss">
  .participants-admin {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }
</style>