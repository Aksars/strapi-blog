"use client"

import { useState } from 'react'
import styles from './LikeButton.module.css'
interface LikeButtonProps {
  initialLikes: number
  postId: string | number
}

export default function AnimatedLikeButton({ initialLikes, postId }: LikeButtonProps) {
  const [likes, setLikes] = useState(initialLikes)
  const [isLiked, setIsLiked] = useState(false)
  const [isAnimating, setIsAnimating] = useState(false)

  const handleLike = async () => {
    if (isAnimating) return
    
    setIsAnimating(true)
    
    try {
      if (isLiked) {
        setLikes(prev => prev - 1)
      } else {
        setLikes(prev => prev + 1)
      }
      setIsLiked(!isLiked)
      
      // Анимация длится 600ms
      setTimeout(() => setIsAnimating(false), 200)
      
      // API вызов здесь
    } catch (error) {
      console.error('Ошибка:', error)
      setLikes(initialLikes)
      setIsAnimating(false)
    }
  }

  return (
    <button
      onClick={handleLike}
      disabled={isAnimating}
      className={`${styles.likeBtn} relative flex  ${
        isLiked
          ? 'bg-red-50 text-red-600 border border-red-200'
          : 'bg-gray-50 text-gray-600 border border-gray-200 hover:bg-gray-100'
      } `}
    >
      {/* Анимированное сердечко */}
      <div className="relative">
        <svg
          className={`w-5 h-5 transition-all duration-200 ${
            isLiked 
              ? 'fill-red-600' 
              : 'fill-none stroke-current'
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
        
        {/* Эффект пульсации */}
        {isAnimating && !isLiked && (
          <div className="absolute inset-0 bg-red-200 rounded-full animate-ping opacity-75"></div>
        )}
      </div>
      
      <span className={ `${styles.likesCounter} text-sm font-medium transition-all duration-300` }>
        {likes}
      </span>
    </button>
  )
}