"use client"

import { useState, useEffect } from 'react'
import styles from './LikeButton.module.css'

interface LikeButtonProps {
  initialLikes: number
  documentId: string | number
}

const likedPostsKey = 'liked_posts'

function getLikedPosts() {
  if (typeof window === 'undefined') return []
  return JSON.parse(localStorage.getItem(likedPostsKey) || '[]')
}

function setLikedPosts(posts: string[]) {
  localStorage.setItem(likedPostsKey, JSON.stringify(posts))
}

export default function AnimatedLikeButton({ initialLikes, documentId }: LikeButtonProps) {
  const [likes, setLikes] = useState(initialLikes)
  const [isLiked, setIsLiked] = useState(false)
  const [isAnimating, setIsAnimating] = useState(false)
  const [isReady, setIsReady] = useState(false) // <-- новое состояние

  useEffect(() => {
    const liked = getLikedPosts().includes(documentId.toString())
    setIsLiked(liked)
    setIsReady(true) // <-- после чтения localStorage показываем кнопку
  }, [documentId])

  const handleLike = async () => {
    if (isAnimating) return
    setIsAnimating(true)

    try {
      const endpoint = isLiked
        ? `/api/posts/${documentId}/unlike`
        : `/api/posts/${documentId}/like`

      // optimistic update
      setLikes((prev) => prev + (isLiked ? -1 : 1))
      setIsLiked(!isLiked)

      const res = await fetch(endpoint, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
      })

      if (!res.ok) throw new Error('Ошибка API')

      // обновляем localStorage
      const likedPosts = getLikedPosts()
      if (isLiked) {
        setLikedPosts(likedPosts.filter((id:string) => id !== documentId.toString()))
      } else {
        setLikedPosts([...likedPosts, documentId.toString()])
      }
    } catch (error) {
      console.error('Ошибка:', error)
      setLikes(initialLikes)
      setIsLiked(false)
    } finally {
      setTimeout(() => setIsAnimating(false), 200)
    }
  }
  if (!isReady) {
    // Skeleton кнопка с пульсацией
    return (
     <button
        className={`${styles.likeBtn} rounded-sm bg-gray-200 animate-pulse`}
       
      >
        <div className="relative">
         <svg
          className={`w-5 h-5 transition-all duration-200`}
          viewBox="0 0 24 24"
          strokeWidth="2"
        >
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z"
          />
        </svg>
        
      </div>
        {/* <div className="w-2 h-4 bg-gray-300 rounded"></div> */}
        <span className={`${styles.likesCounter} text-sm font-medium transition-all duration-300`}>
         1
       </span>
      </button>
    )
  }

  // if (!isReady) {
  //   // Заглушка: кнопка прозрачная или skeleton
  //   return (
  //     <button
      
  //     disabled={true}
  //     className={`${styles.likeBtn} relative flex opacity-10 ${
  //       isLiked
  //         ? 'bg-red-50 text-red-600 border border-red-200'
  //         : 'bg-gray-50 text-gray-600 border border-gray-200 hover:bg-gray-100'
  //     }`}
  //   >
  //     <div className="relative">
  //       <svg
  //         className={`w-5 h-5 transition-all duration-200 ${
  //           isLiked ? 'fill-red-600' : 'fill-none stroke-current'
  //         } ${isAnimating ? 'scale-125' : ''}`}
  //         viewBox="0 0 24 24"
  //         strokeWidth="2"
  //       >
  //         <path
  //           strokeLinecap="round"
  //           strokeLinejoin="round"
  //           d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z"
  //         />
  //       </svg>
  //       {isAnimating && !isLiked && (
  //         <div className="absolute inset-0 bg-red-200 rounded-full animate-ping opacity-75"></div>
  //       )}
  //     </div>

  //     <span className={`${styles.likesCounter} text-sm font-medium transition-all duration-300`}>
  //       .
  //     </span>
  //   </button>
  //   )
  // }

  return (
    
    <>
    







 <button
      onClick={handleLike}
      disabled={isAnimating}
      className={`${styles.likeBtn} relative flex ${
        isLiked
          ? 'bg-red-50 text-red-600 border border-red-200'
          : 'bg-gray-50 text-gray-600 border border-gray-200 hover:bg-gray-100'
      }`}
    >
      <div className="relative">
        <svg
          className={`w-5 h-5 transition-all duration-200 ${
            isLiked ? 'fill-red-600' : 'fill-none stroke-current'
          } ${isAnimating ? 'scale-125' : ''}`}
          viewBox="0 0 24 24"
          strokeWidth="2"
        >
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z"
          />
        </svg>
        {isAnimating && !isLiked && (
          <div className="absolute inset-0 bg-red-200 rounded-full animate-ping opacity-75"></div>
        )}
      </div>

      <span className={`${styles.likesCounter} text-sm font-medium transition-all duration-300`}>
        {likes}
      </span>
    </button>





    </>
   
  )
}
