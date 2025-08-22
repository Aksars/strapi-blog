interface SimpleContentProps {
  content: string;
}

export default function SimpleContent({ content }: SimpleContentProps) {
  // Преобразуем markdown-синтаксис изображений в HTML
  const processedContent = content.replace(
    /!\[(.*?)\]\((.*?)\)/g, 
    '<img src="$2" alt="$1" class="my-4 rounded-lg max-w-full h-auto" loading="lazy" />'
  );

  return (
    <div 
      className="prose max-w-none"
      dangerouslySetInnerHTML={{ __html: processedContent }}
    />
  );
}