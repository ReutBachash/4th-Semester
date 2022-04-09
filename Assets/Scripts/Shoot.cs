using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using UnityEngine.UI;
using TMPro;

public class Shoot : MonoBehaviour
{
    [SerializeField] private float _hitRange=20000;

    [SerializeField] private Camera mainCamera;
    [SerializeField] private LayerMask mouseColiderLayerMask;

    [SerializeField] private TextMeshProUGUI bulletsAvailable;
    public event Action<EnemyIdentity> onEnemyDeath;

    private int availableBullets = 6;

    [SerializeField] private int maximumBullets = 6;
    [SerializeField] private Animator animator;

    [SerializeField] private ParticleSystem muzzleFlash; 
    [SerializeField] private ParticleSystem hitEffect; 
    [SerializeField] private ParticleSystem hitEffectBlood; 

    // Update is called once per frame
    void Update()
    {

        bulletsAvailable.text = ("Bullets Available: " + availableBullets);

        if (Input.GetMouseButtonDown(0))
        {
            animator.SetTrigger("Shoting");
            RayShoot();
        }

        if(availableBullets<maximumBullets)
        {
            if (Input.GetMouseButtonDown(1))
            {
                availableBullets = maximumBullets;
                FindObjectOfType<AudioManager>().Play("Reload");
                animator.SetTrigger("Reload");
            }
        }
    }


    void RayShoot()
    {
        if(availableBullets == 0)
        {
            FindObjectOfType<AudioManager>().Play("noAmmo");
        }
        else
        {
            FindObjectOfType<AudioManager>().Play("PlayerShoot");
        }
        Ray ray = mainCamera.ScreenPointToRay(Input.mousePosition);
        if (Physics.Raycast(ray, out RaycastHit hit, _hitRange, mouseColiderLayerMask))
        {
            Debug.DrawLine(ray.origin, hit.point,Color.blue);
            if(availableBullets>0)
            {
                availableBullets--;
                muzzleFlash.Play();
                hitEffect.transform.position = hit.point;
                hitEffect.Play();
                if (hit.transform.CompareTag("Enemy") && (hit.transform.GetComponentInParent<EnemyIdentity>().isAlive))
                {
                    onEnemyDeath.Invoke(hit.transform.GetComponentInParent<EnemyIdentity>());
                    hit.transform.parent.GetComponentInParent<Animator>().SetTrigger("Death");
                    hit.transform.parent.GetComponentInParent<EnemiesMovement>().StopMovement();
                    hitEffectBlood.transform.position = hit.point;

                    hitEffectBlood.Play();
                }
          
            }

        }
    }
}
