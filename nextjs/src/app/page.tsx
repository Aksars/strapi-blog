import Image from "next/image";
import styles from "./page.module.css";
import PostsList from '../components/PostsList'

export default function Home() {
  return (

    <div className={`${styles.page} ` }>
      Главная страница
     <PostsList limit={2}  />
      
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

