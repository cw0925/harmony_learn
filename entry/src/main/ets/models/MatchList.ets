
export interface MatchList {
  data: MatchModel[];
}

export interface MatchModel {
  id: number;
  name: string;
  beginTime: string;
  place: string;
  browse: number;
  status: number;
  cover: Cover
}

export interface Cover {
  cover: string;
}