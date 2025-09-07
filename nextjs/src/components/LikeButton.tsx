'use client'

import { useState } from 'react'
import { useMutation, useQueryClient, useQuery } from '@tanstack/react-query'
import styles from './LikeButton.module.css'
const API_BASE_URL = process.env.NEXT_PUBLIC_APP_URL || 'http://localhost:3000';

interface LikeButtonProps {
  initialLikes: number,
  documentId: string | number
}

export default function LikeButton({ initialLikes, documentId }: LikeButtonProps) {
  const queryClient = useQueryClient()
  const [isAnimating, setIsAnimating] = useState(false)

  // Получаем данные через useQuery и initialData
  const { data: post } = useQuery({
    queryKey: ['post', documentId],
    queryFn: async () => {
      const res = await fetch(`${API_BASE_URL}/api/posts/${documentId}/`,)
      console.log("Попытка непонятной загрузки")
      if (!res.ok) throw new Error('Ошибка загрузки лайков')
      return res.json() as Promise<{ likes: number; liked: boolean }>
    },
    initialData: () =>
      queryClient.getQueryData(['post', documentId]) ?? { likes: initialLikes, liked: false },
  })

  // Мутации (лайк / анлайк)
  const likeMutation = useMutation({
    mutationKey: ['like', documentId],
    mutationFn: async () => {

      const url = `/api/posts/${documentId}/like`
      console.log("Попытка лайка", url)
    
      const res = await fetch(url, { method: 'POST' })
     
      console.log("Результат = ", res)

      if (!res.ok) throw new Error('Ошибка API лайка')
      return res.json()
    },
    onMutate: async () => {
      setIsAnimating(true)
      await queryClient.cancelQueries({ queryKey: ['post', documentId] })
      const prevData = queryClient.getQueryData(['post', documentId])
      queryClient.setQueryData(['post', documentId], (old: any) => ({
        likes: (old?.likes ?? post?.likes) + 1,
        liked: true,
      }))
      return { prevData }
    },
    onError: (_err, _vars, context) => {
      console.error("Ошибка мутации:", _err)
      if (context?.prevData) queryClient.setQueryData(['post', documentId], context.prevData)
    },
    onSuccess: (data) => {
      console.log("Успешно:", data)
    },
    onSettled: () => {
      console.log("onSettled:")
      queryClient.invalidateQueries({ queryKey: ['post', documentId] })
      setTimeout(() => setIsAnimating(false), 200)
    },
  })

  const unlikeMutation = useMutation({
    mutationKey: ['unlike', documentId],
    mutationFn: async () => {
      const url = `/api/posts/${documentId}/unlike`
      console.log("Попытка анлайка", url)
      const res = await fetch(url, { method: 'POST' })

      if (!res.ok) throw new Error('Ошибка API анлайка')
      return res.json()
    },
    onMutate: async () => {
      setIsAnimating(true)
      await queryClient.cancelQueries({ queryKey: ['post', documentId] })
      const prevData = queryClient.getQueryData(['post', documentId])
      queryClient.setQueryData(['post', documentId], (old: any) => ({
        likes: (old?.likes ?? post?.likes) - 1,
        liked: false,
      }))
      return { prevData }
    },
    onError: (_err, _vars, context) => {
      if (context?.prevData) queryClient.setQueryData(['post', documentId], context.prevData)
    },
    onSettled: () => {
      queryClient.invalidateQueries({ queryKey: ['post', documentId] })
      setTimeout(() => setIsAnimating(false), 200)
    },
  })

  const handleClick = () => {
    console.log("Тыкаем в кнопочку лайка")
    console.log("isAnimating = ", isAnimating)
    console.log("post.liked = ", post?.liked)
    if (isAnimating) return
    post?.liked ? unlikeMutation.mutate() : likeMutation.mutate()
  }

  return (
    <button
      onClick={handleClick}
      disabled={isAnimating}
      className={`${styles.likeBtn} relative flex ${post?.liked
        ? 'bg-red-50 text-red-600 border border-red-200'
        : 'bg-gray-50 text-gray-600 border border-gray-200 hover:bg-gray-100'
        }`}
    >
      <div className="relative">
        <svg
          className={`w-5 h-5 transition-all duration-200 ${post?.liked ? 'fill-red-600' : 'fill-none stroke-current'} ${isAnimating ? 'scale-125' : ''}`}
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
      <span className={`${styles.likesCounter} text-sm font-medium transition-all duration-300 ml-1`}>
        {post?.likes}
      </span>
    </button>
  )
}
