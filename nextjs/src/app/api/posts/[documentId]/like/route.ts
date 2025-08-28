import { NextResponse } from "next/server";

export async function POST(
  req: Request,
  { params }: { params: { documentId: string } }
) {
  const strapiUrl = `${process.env.NEXT_PUBLIC_STRAPI_API_URL}/api/posts/${params.documentId}/like`;

  try {
    const res = await fetch(strapiUrl, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: await req.text(), // если у тебя нет body — можно убрать
    });

    const data = await res.json();
    return NextResponse.json(data, { status: res.status });
  } catch (err) {
    console.error("Proxy error:", err);
    return NextResponse.json(
      { error: "Failed to connect to Strapi" },
      { status: 500 }
    );
  }
}
