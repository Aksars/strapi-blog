// серверный компонент
export default async function ISRBlock() {
  const res = await fetch("https://jsonplaceholder.typicode.com/posts/3", {
    next: { revalidate: 10 }, // пересборка каждые 10 секунд
  })
  const post = await res.json()

  return (
    <div className="border p-4 rounded">
      <h2 className="font-bold">ISR (Incremental Static Regeneration)</h2>
      <p>{post.title}</p>
    </div>
  )
}