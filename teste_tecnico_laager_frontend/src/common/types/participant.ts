
export interface Participant {
    id: number;
    name: string;
    total_votes: number;
    created_at: string;
    updated_at: string;
}

export interface ParticipantsStatistics {
    total_votes: number;
    participants: Partial<Participant>[];
}