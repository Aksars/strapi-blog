"use client"
import styles from "./PostSearch.module.css";
import {
    useEffect,
    useRef,
    useState,
} from "react";
import { getPosts } from '@/lib/strapi';

export default function PostSearch() {




    //const [inputVal, setInputVal] = useState<string>("")
    const [postNames, setPostNames] = useState<any>()
    const inputRef = useRef(null)
    const timerRef = useRef<NodeJS.Timeout | null>(null);

    function handleClick(e: React.ChangeEvent<HTMLInputElement>) {

        if (timerRef.current) {
            clearTimeout(timerRef.current);
        }
        timerRef.current = setTimeout(async () => {
            // setInputVal(e.target.value);
            const posts = await getPosts();
            setPostNames(posts)
        }, 500);

    }

    useEffect(() => {

        return () => {
            if (timerRef.current) {
                clearTimeout(timerRef.current);
            }
        }
    }, [])


    return (

        <div className={styles.search}>
            <h2>Окно с поиском</h2>
            <input className={styles.searchInput} type="text" ref={inputRef}
                onChange={handleClick} />

            <div className={styles.searchResults}>
                тут будут результаты <br />
                {postNames}
            </div>


        </div>
    );
}