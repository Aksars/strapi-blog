// 1. БАЗОВЫЕ ТИПЫ ОТВЕТА API
// ----------------------------
export interface StrapiResponse<T> {
  data: T;
  meta?: {
    pagination?: {
      page: number;
      pageSize: number;
      pageCount: number;
      total: number;
    };
  };
}

// 2. ТИП СУЩНОСТИ (ПОСТА)
// ----------------------------
export interface Post {
  id: number;
  documentId: string;
  title: string;
  slug: string;
  content: string;
  createdAt: string;
  updatedAt: string;
  publishedAt?: string;
  likes?: number | null;
  image?:unknown
  publish_date?: string;
  category:unknown
}

// 3. ТИПИЗИРОВАННЫЕ ОТВЕТЫ API
// ----------------------------
// Для запроса всех постов: GET /api/posts
export type PostsResponse = StrapiResponse<Post[]>;

// Для запроса одного поста: GET /api/posts/1 или ?filters[slug][$eq]=...
export type PostResponse = StrapiResponse<Post>;

// 4. ПАРАМЕТРЫ ЗАПРОСА (если нужно)
// ----------------------------
export interface PostsParams {
  populate?: string;
  filters?: Record<string, unknown>;
  sort?: string[];
  pagination?: {
    page?: number;
    pageSize?: number;
  };
}