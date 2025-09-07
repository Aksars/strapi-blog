// components/PostsList.tsx
import { getPosts } from '@/lib/strapi';
import Link from 'next/link';
import LikeButton from './LikeButton'

interface PostsListProps {
  limit?: number;
  showDate?: boolean;
  sortBy?: 'newest' | 'oldest';
  category?: string;
  className?: string;
  showExcerpt?: boolean;
  excerptLength?: number;
}

export default async function PostsList({
  limit,
  showDate = true,
  sortBy = 'newest',
 // category,
  className = "",
  showExcerpt = false,
  excerptLength = 150
}: PostsListProps) {
  const posts = await getPosts();
  console.log("получены посты = ", posts)
  
  // // Фильтрация по категории
  // if (category) {
  //   posts = posts.filter(post => post.category?.slug === category);
  // }
  
  // Сортировка
  posts.sort((a, b) => {
    const dateA = new Date(a.createdAt).getTime();
    const dateB = new Date(b.createdAt).getTime();
    return sortBy === 'newest' ? dateB - dateA : dateA - dateB;
  });
  
  // Лимит
  const displayedPosts = limit ? posts.slice(0, limit) : posts;

  if (displayedPosts.length === 0) {
    return <div className={className}>Постов не найдено.</div>;
  }

  // Функция для обрезки текста
  const truncateText = (text: string, maxLength: number) => {
    if (text.length <= maxLength) return text;
    return text.substr(0, maxLength) + '...';
  };

  return (
    <div className={className}>
      <ul className="space-y-6">
        {displayedPosts.map((post) => (
          <li key={post.id} className="border-b pb-6 last:border-b-0">
            <Link 
              href={`/posts/${post.slug}`}
              className="block hover:bg-gray-50 p-4 rounded-lg transition-colors"
            > 
              <h2 className="text-xl font-semibold text-gray-900 hover:text-blue-600 mb-2">
                {post.title}
              </h2>
              
              {showExcerpt && post.content && (
                <p className="text-gray-600 mb-3">
                  {truncateText(post.content, excerptLength)}
                </p>
              )}
              
              {showDate && (
                <p className="text-sm text-gray-500">
                  Создан: {new Date(post.createdAt).toLocaleDateString('ru-RU')}
                </p>
              )}
            </Link>
            <LikeButton documentId={post.documentId} initialLikes={post.likes || 0} />           
          </li>
        ))}
      </ul>
      <>{ console.log("КОНЕЦ ПОСТОВ ВРЕМЯ, ", new Date())}</>
    </div>
  );
}