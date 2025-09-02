"use client"

import { useEffect, useState } from "react"

// Тип для поста
interface Post {
  userId: number
  id: number
  title: string
  body: string
}

export default function CSRPosts() {
  const [posts, setPosts] = useState<Post[]>([])
  const [loading, setLoading] = useState<boolean>(true)

  useEffect(() => {
    const fetchPosts = async () => {
      try {
        const res = await fetch(
          "https://jsonplaceholder.typicode.com/posts?_limit=5"
        )
        if (!res.ok) throw new Error("Failed to fetch posts")
        const data: Post[] = await res.json()
        setPosts(data)
      } catch (err) {
        console.error(err)
      } finally {
        setLoading(false)
      }
    }

    fetchPosts()
  }, [])

  return (
    <div className="border p-4 rounded">
      <h2 className="font-bold">CSR (Client-Side Rendering)</h2>
      {loading ? (
        <p>Загрузка...</p>
      ) : (
        posts.map((post) => <p key={post.id}>{post.title}</p>)
      )}
    </div>
  )
}
