// import { Post, PostsResponse } from '@/types/strapi';

const API_BASE_URL = process.env.NEXT_PUBLIC_APP_URL || 'http://localhost:3000';

// export async function getPosts(): Promise<Post[]> {
//   try {
//     const response = await fetch(
//       `${API_BASE_URL}/api/posts?populate=image,category`,
//       { cache: 'no-store' }
//     );

//     console.log(response)

//     if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

//     const postsData: PostsResponse = await response.json();
//     return postsData.data || [];
//   } catch (error) {
//     console.error('Error fetching posts:', error);
//     return [];
//   }
// }



export async function getPosts() {
  const res = await fetch(`${API_BASE_URL}/api/posts/`, { cache: 'no-store' });

  if (!res.ok)
    throw new Error(`HTTP error! status: ${res.status}`);

  const data = await res.json();
  return data.data || [];
}

export async function getPostByDocId(docId: string) {
  console.log(`Пробую получить 1 пост по некст-апи ${API_BASE_URL}/api/posts/${docId}`)
  const res = await fetch(`${API_BASE_URL}/api/posts/${docId}/`, { cache: 'no-store' });
  console.log("результат получения 1 поста", res.status)
  if (!res.ok)
    throw new Error(`HTTP error! status: ${res.status}`);
  const data = await res.json();
  console.log("данные поста", data)
  return data.data;
}
