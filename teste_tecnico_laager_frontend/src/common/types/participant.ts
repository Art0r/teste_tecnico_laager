
export interface Participant {
    id: number;
    name: string;
    votes_count: number;
    created_at: string;
    updated_at: string;
}

export interface ParticipantsStatistics {
    total_votes: number;
    votes_per_hour: number;
    participants: Partial<Participant>[];
}