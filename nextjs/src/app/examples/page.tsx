// app/page.tsx (серверный компонент по умолчанию)
import { Suspense } from "react"
import SSRBlock from "@/components/SSRBlock"
import SSGBlock from "@/components/SSGBlock"
import ISRBlock from "@/components/ISRBlock"
import CSRPosts from "@/components/CSRPosts"

export default function Page() {
  return (
    <div className="space-y-6 p-6">
      <h1 className="text-2xl font-bold">Демо стратегий рендеринга</h1>

      <Suspense fallback={<p>Загрузка SSR...</p>}>
        <SSRBlock />
      </Suspense>

      <Suspense fallback={<p>Загрузка SSG...</p>}>
        <SSGBlock />
      </Suspense>

      <Suspense fallback={<p>Загрузка ISR...</p>}>
        <ISRBlock />
      </Suspense>

      {/* Это чисто клиентский */}
      <CSRPosts />
    </div>
  )
}