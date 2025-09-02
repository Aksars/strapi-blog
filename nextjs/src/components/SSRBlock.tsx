// серверный компонент по умолчанию
export default async function SSRBlock() {
  const res = await fetch("https://jsonplaceholder.typicode.com/posts/1", {
    cache: "no-store", // всегда свежий запрос
  })
  const post = await res.json()

  return (
    <div className="border p-4 rounded">
      <h2 className="font-bold">SSR (Server-Side Rendering)</h2>
      <p>{post.title}</p>
    </div>
  )
}