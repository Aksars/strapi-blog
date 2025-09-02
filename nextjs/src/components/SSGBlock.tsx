// серверный компонент
export default async function SSGBlock() {
  const res = await fetch("https://jsonplaceholder.typicode.com/posts/2", {
    cache: "force-cache", // закэшировано при билде
  })
  const post = await res.json()

  return (
    <div className="border p-4 rounded">
      <h2 className="font-bold">SSG (Static Site Generation)</h2>
      <p>{post.title}</p>
    </div>
  )
}