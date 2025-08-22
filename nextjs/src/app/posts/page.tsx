import { getPosts } from '@/lib/strapi';
import Link from 'next/link';

export default async function PostsPage() {
  const posts = await getPosts();

  if (posts.length === 0) {
    return <div>Постов не найдено.</div>;
  }

  return (
    <div>
      <h1>Блог</h1>
      <ul>
        {posts.map((post) => (
          <li key={post.id}>
            {/* Теперь БЕЗ attributes! */}
            <Link href={`/posts/${post.slug}`}>
              <h2>{post.title}</h2>
            </Link>
            <p>Создан: {new Date(post.createdAt).toLocaleDateString('ru-RU')}</p>
          </li>
        ))}
      </ul>
    </div>
  );
}