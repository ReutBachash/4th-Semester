using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SelectableObjects : MonoBehaviour
{
    [SerializeField] private string selecableTag = "Selectable";
    [SerializeField] Material highLightMaterial;
    [SerializeField] Material defaultMatrial;
    [SerializeField] Material civMatrial;
    private Identity script;
    private Transform _selection;

    // Update is called once per frame
    void Update()
    {
        if(_selection!=null)
        {
            var selctionRenderer = _selection.GetComponent<Renderer>();
            selctionRenderer.material = defaultMatrial;
            _selection = null;
        }
        var ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        RaycastHit hit;
        if(Physics.Raycast(ray,out hit))
        {
            if(Input.GetMouseButtonDown(0))
            {
                var selection = hit.transform;
                script = selection.GetComponent<Identity>();
                if (selection.CompareTag(selecableTag)&& script.identityBehvoiur== "Enemy")
                {
                    var selctionRenderer = selection.GetComponent<Renderer>();
                    if (selctionRenderer != null)
                    {
                        selctionRenderer.material = highLightMaterial;
                    }
                    _selection = selection;
                }
                else if (selection.CompareTag(selecableTag) && script.identityBehvoiur == "Civilian")
                {
                    var selctionRenderer = selection.GetComponent<Renderer>();
                    if (selctionRenderer != null)
                    {
                        selctionRenderer.material = civMatrial;
                    }
                    _selection = selection;
                }
            }
         
          
        }
    }
}
