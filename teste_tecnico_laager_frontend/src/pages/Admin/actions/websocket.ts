import type {ParticipantsStatistics} from "@/common/types/participant.ts";

type WebSocketMessageType = 'ping' | 'welcome' | 'confirm_subscription' | 'statistics_update';

export const webSocketBehaviors: Record<WebSocketMessageType, (channel?: string) => void> = {
    "ping": () => console.log("Ignoring - ping only"),
    "welcome": () => console.log("Successfully connected to WebSocket"),
    "confirm_subscription": () => console.log("Successfully subscribed to StatisticsChannel"),
    "statistics_update": () => console.log("Statistics updated"),
}

export const webSocketBehaviorsOnMessage = (event: MessageEvent, store: any) => {
    const data = JSON.parse(event.data);
    const messageType = data.type as WebSocketMessageType;

    if (webSocketBehaviors[messageType]) webSocketBehaviors[messageType]();

    if (data.message?.data) {
        const body = data.message.data as ParticipantsStatistics;
        store.updateStatistics(body);
    }
}