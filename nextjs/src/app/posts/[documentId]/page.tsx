import { getPostByDocId as getPostByDocId } from '@/lib/strapi';
import { notFound } from 'next/navigation';
import SimpleContent from '@/components/SimpleContent'; // Импортируем наш компонент

// export async function generateStaticParams() {
//   const posts = await getPosts();
//   return posts.map((post) => ({
//     slug: post.slug, // БЕЗ attributes!
//   }));
// }
export const revalidate = 0; // Отключает кэширование
export const dynamic = 'force-dynamic'; // Динамическая маршрутизация
export async function generateMetadata() {
    return {
        cache: 'no-store', // Отключает кэш браузера
    };
}

export default async function PostPage({ params }: {
    params: Promise<{ documentId: string }>
}) {
   
    const { documentId } = await params;
     console.log("Страница получения поста по docID = ",documentId)
    const post = await getPostByDocId(documentId);
    console.log('Загружен пост:', post?.title);
    console.log('Лайков у поста:', post?.likes);
    if (!post) {
        notFound();
    }

    return (
        <article className="max-w-4xl mx-auto px-4 py-8">
            <h1 className="text-4xl font-bold mb-4">{post.title}</h1>
            <p className="text-gray-600 mb-8">
                Опубликовано: {new Date(post.createdAt).toLocaleDateString('ru-RU')}
            </p>

            {/* Используем наш простой компонент */}
            <SimpleContent content={post.content} />
        </article>
    );
}