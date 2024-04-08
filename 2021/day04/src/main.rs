fn main() {
    let test_file = "example.txt";
    let real_file = "input.txt";
    part_one(test_file);
    part_one(real_file);
    println!("\nPart Two:\n");
    part_two(test_file);
    part_two(real_file);
}

fn part_two(filename: &str) {
    let contents =
        std::fs::read_to_string(filename).expect("Something went wrong reading the file");
    let contents = contents.split("\n\n").collect::<Vec<&str>>();
    let balls = contents[0].split(",").collect::<Vec<&str>>();
    let contents = contents[1..]
        .iter()
        .map(|x| x.split("\n").filter(|l| l.len() > 0).collect::<Vec<&str>>())
        .collect::<Vec<Vec<&str>>>();

    let mut games: Vec<Vec<Vec<&str>>> = Vec::new();

    for game in contents.iter() {
        let mut temp_game: Vec<Vec<&str>> = Vec::new();
        for line in game.iter() {
            let temp_line = line
                .trim()
                .split(" ")
                .filter(|x| x.len() > 0)
                .collect::<Vec<&str>>();
            temp_game.push(temp_line);
        }
        games.push(temp_game);
    }

    let games_in_play: usize = games.len();
    let mut games_hashmap = std::collections::HashMap::new();
    for ball in balls.iter() {
        for (i, game) in games.iter_mut().enumerate() {
            for line in game.iter_mut() {
                if line.contains(&ball) {
                    let index = line.iter().position(|x| x == ball).unwrap();
                    line[index] = "X";
                }
            }
            if is_winner(game.to_vec()) {
                games_hashmap.insert(i, true);
                if games_in_play - games_hashmap.len() == 0 {
                    println!("Winner!");
                    println!(
                        "RESULT: {}",
                        leftover_sum(game.to_vec()) * ball.parse::<i32>().unwrap()
                    );
                    return;
                }
            }
        }
    }
}

fn part_one(filename: &str) {
    let contents =
        std::fs::read_to_string(filename).expect("Something went wrong reading the file");
    let contents = contents.split("\n\n").collect::<Vec<&str>>();
    let balls = contents[0].split(",").collect::<Vec<&str>>();
    let contents = contents[1..]
        .iter()
        .map(|x| x.split("\n").filter(|l| l.len() > 0).collect::<Vec<&str>>())
        .collect::<Vec<Vec<&str>>>();

    let mut games: Vec<Vec<Vec<&str>>> = Vec::new();

    for game in contents.iter() {
        let mut temp_game: Vec<Vec<&str>> = Vec::new();
        for line in game.iter() {
            let temp_line = line
                .trim()
                .split(" ")
                .filter(|x| x.len() > 0)
                .collect::<Vec<&str>>();
            temp_game.push(temp_line);
        }
        games.push(temp_game);
    }

    for ball in balls.iter() {
        for game in games.iter_mut() {
            for line in game.iter_mut() {
                if line.contains(&ball) {
                    let index = line.iter().position(|x| x == ball).unwrap();
                    line[index] = "X";
                }
            }
            if is_winner(game.to_vec()) {
                println!("Winner!");
                println!("{:?}", game);
                println!(
                    "RESULT: {}",
                    leftover_sum(game.to_vec()) * ball.parse::<i32>().unwrap()
                );
                return;
            }
        }
    }
}

fn leftover_sum(game: Vec<Vec<&str>>) -> i32 {
    let mut sum = 0;
    for line in game.iter() {
        for c in line.iter() {
            if c != &"X" {
                sum += c.parse::<i32>().unwrap();
            }
        }
    }
    return sum;
}

fn is_winner(game: Vec<Vec<&str>>) -> bool {
    for line in game.iter() {
        if line.iter().all(|x| x == &"X") {
            return true;
        }
    }

    for i in 0..game.len() {
        let mut temp_line = Vec::new();
        for j in 0..game.len() {
            temp_line.push(game[j][i]);
        }
        if temp_line.iter().all(|x| x == &"X") {
            return true;
        }
    }
    return false;
}
