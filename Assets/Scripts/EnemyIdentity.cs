using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyIdentity : MonoBehaviour
{

    public int _enemyNumber;
    public bool isLastEnemyInZone;
    public bool isAlive=false;
    private float amountOfSecBeforeShoot = 3;
    private float currentTime;

    private Shoot shootScript;
   private PlayerHealth playerHealth;

    [SerializeField] GameObject _player;
    private void Start()
    {
        shootScript = _player.GetComponent<Shoot>();
        playerHealth = _player.GetComponent<PlayerHealth>();

        shootScript.onEnemyDeath += Dead;

    }

    private void Dead(EnemyIdentity identity)
    {
        isAlive = false;
    }
    private void Update()
    {
        if(isAlive)
        {
            if (currentTime < amountOfSecBeforeShoot)
            {
                currentTime += Time.deltaTime;
            }
            else
            {
                playerHealth.DecreaseHealth();
                currentTime = 0;
            }
        }
    }
}
