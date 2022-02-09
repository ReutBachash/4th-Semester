using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PlayerPoints : MonoBehaviour
{
    [SerializeField] private Text _points;
    [SerializeField] private float _amountOfPointsPerKill = 100;

    private float pointsMultiplayer = 1.5f;
    private float currentPoints;

    // Start is called before the first frame update
    void Start()
    {
        this.gameObject.GetComponent<Shoot>().onEnemyDeath += AddPoints;
    }

    // Update is called once per frame
    void AddPoints(EnemyIdentity identity)
    {
        currentPoints += _amountOfPointsPerKill * (identity._enemyNumber + 1) * pointsMultiplayer;
        _points.text = ("Points " + currentPoints);
    }
}
