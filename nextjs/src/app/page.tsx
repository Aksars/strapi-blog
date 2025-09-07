// import Image from "next/image";
import styles from "./page.module.css";
import PostsList from '../components/PostsList'
import PostSearch from '../components/PostSearch'

export const revalidate = 0; // Отключает кэширование
export const dynamic = 'force-dynamic'; // Динамическая маршрутизация
export async function generateMetadata() {
  return {
    cache: 'no-store', // Отключает кэш браузера
  };
}

export default function Home() {
  return (

    <div className={`${styles.page} `}>
      Главная страница

      <PostSearch />
      <PostsList limit={2} />

    </div>
  );
}
// "use client"

// import { useEffect } from 'react'
// import { useRouter } from 'next/navigation'

// export default function Home() {
//   const router = useRouter()

//   useEffect(() => {
//     router.push('/posts')
//   }, [router])

//   return null // или loading spinner
//}

