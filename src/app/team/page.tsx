import type { Metadata } from "next";
import Image from "next/image";

export const metadata: Metadata = {
  title: "Team",
};

type TeamMember = {
  name: string;
  role: string;
  initials: string;
  photo?: string;
};

const members: TeamMember[] = [
  {
    name: "Hongxu Zhou",
    role: "Principal Investigator",
    initials: "HZ",
    photo: "/team/zhou.jpg",
  },
  {
    name: "Wei Zheng",
    role: "Co-PI · Principal Research Scientist",
    initials: "WZ",
    photo: "/team/wei.png",
  },
  {
    name: "John W. Scott",
    role: "Illinois State Pollution Prevention Scientist",
    initials: "JS",
    photo: "/team/john.png"
  },
  {
    name: "Rabin Bhattarai",
    role: "Professor in Water Resource Engineering",
    initials: "RB",
    photo: "/team/rabin.jpg"
  },
  {
    name: "Lee Green",
    role: "Associate Research Scientist",
    initials: "LG",
    photo: "/team/lee.png"
  },
  {
    name: "Carolina Garcia",
    role: "Assistant Research Scientist",
    initials: "CG",
    photo: "/team/carolina.png"
  },
  {
    name: "Haribansha Timalsina",
    role: "Ph.D. Candidate in Agricultural and Biological Engineering",
    initials: "HT",
    photo: "/team/haribansha.jpg"
  },
  {
    name: "Sean Williams",
    role: "Team member",
    initials: "SW",
  },
  {
    name: "Yashna Satyan",
    role: "Team member",
    initials: "YS",
  },
  {
    name: "Sanji Lee",
    role: "Team member",
    initials: "SL",
    photo: "/team/sanji.jfif"
  },
  {
    name: "Dominic Mini",
    role: "Team member",
    initials: "DM",
    photo: "/team/dominic.jpg"
  },
  {
    name: "Alicia Chen",
    role: "Team member",
    initials: "AC",
    photo: "/team/alicia.jpg"
  },
  {
    name: "Ino Zhu",
    role: "Team member",
    initials: "IZ",
    photo: "/team/ino.jpg"
  },
  {
    name: "Janaye Jordan",
    role: "Team member",
    initials: "JJ",
  },
];

export default function TeamPage() {
  return (
    <main id="main-content" className="team-page">
      <h1>Project team</h1>

      <section
        aria-label="Team members"
        className="mt-12 grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3"
      >
        {members.map((member) => (
          <article
            key={member.name}
            className="flex flex-col items-center rounded-2xl border border-[var(--line)] bg-white px-6 py-8 text-center shadow-sm"
          >
            <div className="mb-5 flex h-28 w-28 shrink-0 items-center justify-center overflow-hidden rounded-full border-4 border-[var(--orange-soft)] bg-[var(--navy)]">
              {member.photo ? (
                <Image
                  src={member.photo}
                  alt={`Portrait of ${member.name}`}
                  width={112}
                  height={112}
                  className="h-full w-full object-cover"
                />
              ) : (
                <span
                  aria-hidden="true"
                  className="text-3xl text-white"
                  style={{ fontFamily: "var(--serif)" }}
                >
                  {member.initials}
                </span>
              )}
            </div>

            <h2
              className="text-2xl leading-tight text-[var(--navy)]"
              style={{ fontFamily: "var(--serif)" }}
            >
              {member.name}
            </h2>

            <p className="mt-3 max-w-64 text-sm leading-relaxed text-[var(--muted)]">
              {member.role}
            </p>
          </article>
        ))}
      </section>
    </main>
  );
}