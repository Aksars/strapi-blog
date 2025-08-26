import { Post, PostsResponse } from '@/types/strapi';

const STRAPI_API_URL = process.env.STRAPI_API_URL  || 'http://strapi:1337';

export async function getPosts(): Promise<Post[]> {
  try {
    const response = await fetch(`${STRAPI_API_URL}/api/posts?populate[image]=true&populate[category]=true`);
    if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
    
    const postsData: PostsResponse = await response.json();
    return postsData.data || [];
  } catch (error) {
    console.error('Error fetching posts:', error);
    return [];
  }
}

export async function getPostBySlug(slug: string): Promise<Post | null> {
  try {
    const response = await fetch(
      `${STRAPI_API_URL}/api/posts?populate[image]=true&populate[category]=true&filters[slug][$eq]=${slug}`
    );
    console.log(`${STRAPI_API_URL}/api/posts?populate[image]=true&populate[category]=true&filters[slug][$eq]=${slug}`)
    if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
    
    const postsData: PostsResponse = await response.json();
    return postsData.data[0] || null;
  } catch (error) {
    console.error('Error fetching post:', error);
    return null;
  }
}