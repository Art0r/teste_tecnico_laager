import { ref, computed } from 'vue'
import { defineStore } from 'pinia'
import type {Participant, ParticipantsStatistics} from "@/common/types/participant.ts";

interface AdminState {
    participantsStatistics: ParticipantsStatistics,
}

const initialState: AdminState = {
    participantsStatistics: {
        total_votes: 0,
        participants: [],
        votes_per_hour: 0
    }
}

export const useAdminStore = defineStore('vote-statistics-store', {
    state: () => initialState,
    getters: {
        getParticipantsStatistics: (state: AdminState) => state.participantsStatistics,
        getTotalVotes: (state: AdminState) => state.participantsStatistics.total_votes,
        getParticipants: (state: AdminState) => state.participantsStatistics.participants,
        getVotesPerHour: (state: AdminState) => state.participantsStatistics.votes_per_hour
    },
    actions: {
        updateStatistics(newStatistics: ParticipantsStatistics) {
            if (!newStatistics || typeof newStatistics !== 'object') {
                return;
            }

            this.participantsStatistics = newStatistics;
        },
    }
})
