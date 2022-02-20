using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
public class EnemiesZoneSpawnLogic : MonoBehaviour
{
    [SerializeField] Shoot _shootScript;
    [SerializeField] GameObject[] _enemies;

    [SerializeField] private int _zoneNumber;

    [SerializeField] PlayerHealth _playerHealth;

    public event Action<int> onLastEnemykilled;

    [SerializeField] private float amountOfSecBeforeShoot = 5;
    private float currentTime;

    void Start()
    {
        _shootScript.onEnemyDeath += SpawnNextEnemy;

        //Add ZoneConfiguration

        _enemies[0].GetComponent<EnemiesMovement>().SetDestination(); //spawning first enemy
        _enemies[0].GetComponent<EnemyIdentity>().isAlive = true; //spawning first enemy


    }

    // Update is called once per frame
    private void SpawnNextEnemy(EnemyIdentity identity)
    {
        if (!identity._isLastEnemy)
        {
            _enemies[identity._enemyNumber + 1].GetComponent<EnemiesMovement>().SetDestination();
            identity.isAlive = true;
            _enemies[identity._enemyNumber + 1].GetComponent<Animator>().enabled = true;
        }
        else
            onLastEnemykilled!.Invoke(_zoneNumber);
    }

    private void Update()
    { 
        //fix here health issues
        foreach(GameObject enemy in _enemies)
        {
            if(enemy!=null)
            {
                if (enemy.GetComponent<EnemyIdentity>().isAlive)
                {
                    if (currentTime < amountOfSecBeforeShoot)
                    {
                        currentTime += Time.deltaTime;
                    }
                    else
                    {
                        _playerHealth.DecreaseHealth();
                        currentTime = 0;
                    }
                }
            }
           
        }
    }
}
